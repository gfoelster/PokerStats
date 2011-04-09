﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PokerStatsDataAccess
{
    public class DataAccessProvider
    {
        private PokerDBDataContext ctx = new PokerDBDataContext();

        private const int seatCount = 8;

        private static DataAccessProvider _current = null;
        public static DataAccessProvider Current
        {
            get
            {
                if (_current == null)
                    _current = new DataAccessProvider();

                return _current;
            }
        }

        public DataAccessProvider()
        {

        }

        public List<Game> GetActiveGames()
        {
            return ctx.Games.Where(g => g.IsActive).ToList();
        }
        public bool GameNameExists(string gameName)
        {
            return ctx.Games.Any(g => g.Name.ToLower() == gameName.Trim().ToLower());
        }
        public int StartNewGame(string gameName, string userLogin)
        {
            User user = ctx.Users.Single(u => u.Login == userLogin);

            Game newGame = new Game()
            {
                Name  = gameName,
                IsActive = true,
                StartTime = DateTime.Now,
                Round = 0,
                CurrentButtonPosition = 0
            };

            ctx.Games.InsertOnSubmit(newGame);
            ctx.SubmitChanges();

            // ID generated by database
            int gameID = newGame.ID;

            // insert join action
            GameAction joinAction = new GameAction()
            {
                ActionTypeID = (int)ActionTypes.UserJoined,
                GameID = gameID,
                IsCommitted = false,
                UserID = user.ID,
                Timestamp = DateTime.Now
            };
            ctx.GameActions.InsertOnSubmit(joinAction);
            ctx.SubmitChanges();
        

            return gameID;
        }
        public bool JoinGame(int gameID, string userLogin)
        {
            User user = ctx.Users.Single(u => u.Login == userLogin);

            bool hasFreeSeat = false;
            if (ctx.UserSeats.Where(us => us.GameID == gameID).Count() < seatCount)
                hasFreeSeat = true;

            if (hasFreeSeat)
            {
                // insert join action
                GameAction joinAction = new GameAction()
                {
                    ActionTypeID = (int)ActionTypes.UserJoined,
                    GameID = gameID,
                    IsCommitted = false,
                    UserID = user.ID,
                    Timestamp = DateTime.Now
                };

                ctx.GameActions.InsertOnSubmit(joinAction);
                ctx.SubmitChanges();

                return true;
            }
            else
                return false;

        }
        public Game GetGameByID(int gameID)
        {
            return ctx.Games.Single(g => g.ID == gameID);
        }

        public List<GameAction> GetUncommittedActions()
        {
            List<GameAction> uncommittedActions = ctx.GameActions.Where(ga => !ga.IsCommitted)
                                                                 .OrderBy(ga => ga.ID)
                                                                 .ToList();
            return uncommittedActions;
        }
        public List<GameAction> GetCommittedActions(int gameID, int fromPositionInclusive)
        {
            return ctx.GameActions.Where(ga => ga.GameID == gameID && ga.ID >= fromPositionInclusive)
                                  .OrderBy(ga => ga.ID)
                                  .ToList();
        }

        public List<int> GetUsersInGame(Game game)
        {
            List<int> joinedUsers = ctx.UserSeats.Where(us => us.GameID == game.ID).Select(us => us.UserID).ToList();
            return joinedUsers;
        }
        public int GetFreeSeat(Game game)
        {
            List<int> reservedSeats = ctx.UserSeats.Where(us => us.GameID == game.ID).Select(us => us.Seat).ToList();
            int freeSeatCount = seatCount - reservedSeats.Count;
            if(freeSeatCount == 0)
                return 0;

            Random rnd = new Random((int)DateTime.Now.Ticks);
            int freeSeatIndex = rnd.Next(1, freeSeatCount);

            // get the n-th free seat
            int freeSeatNumber = 1;
            for (int i = 1; i <= seatCount; i++)
            {
                if (freeSeatIndex == freeSeatNumber)
                    break;
                else if(!reservedSeats.Contains(i))
                    freeSeatNumber++;
            }

            return freeSeatNumber;
        }






        #region Game Actions

        public void PlaceUserOnFreeSeat(Game game, int userID, int gameActionID)
        {
            int freeSeat = GetFreeSeat(game);
            UserSeat seat = new UserSeat()
            {
                GameID = game.ID,
                Seat = freeSeat,
                UserID = userID
            };
            ctx.UserSeats.InsertOnSubmit(seat);
            ctx.SubmitChanges();

            Console.WriteLine(String.Format("User is placed on seat {0}.", freeSeat));

            GameAction action = ctx.GameActions.Single(ga => ga.ID == gameActionID);
            action.Data = seat.ToString();
            action.IsCommitted = true;
            ctx.SubmitChanges();
        }

        public int GetCard(List<int> availableCards)
        {
            Random rnd = new Random((int)DateTime.Now.Ticks);
            int freeCardIndex = rnd.Next(1, availableCards.Count);

            // get the n-th free card
            int freeCardNumber = 1;
            for (int i = 1; i < availableCards.Count; i++)
            {
                if (freeCardIndex == freeCardNumber)
                    break;
                else if (availableCards.Contains(i))
                    freeCardNumber++;
            }

            // remove from deck
            availableCards.Remove(freeCardNumber);

            return freeCardNumber;
        }

        public void WaitForPlayers(Game game, int userID)
        {
            Console.WriteLine("Wait for players.");
            GameAction waitAction = new GameAction()
            {
                ActionTypeID = (int)ActionTypes.WaitForPlayers,
                GameID = game.ID,
                UserID = userID,
                Timestamp = DateTime.Now,
                IsCommitted = true
            };

            ctx.GameActions.InsertOnSubmit(waitAction);
            ctx.SubmitChanges();
        }

        public void PayBlinds(Game game)
        {
            // the next round begins!
            game.Round++;
            Console.WriteLine(string.Format("Round {0} begins."));

            // advance button position
            int buttonPosition = game.CurrentButtonPosition;
            List<UserSeat> seats = ctx.UserSeats.Where(us => us.GameID == game.ID)
                                           .OrderBy(us => us.Seat)
                                           .ToList();

            // get next occupied seat 
            while (!seats.Any(s => s.Seat == buttonPosition))
            {
                buttonPosition++;

                if (buttonPosition > seatCount)
                    buttonPosition = 1;
            }

            Console.WriteLine("Move dealer button, pay blinds.");
            game.CurrentButtonPosition = buttonPosition;

            int dealer = seats.Single(s => s.Seat == buttonPosition).UserID;
            int smallBlind = -1;
            int bigBlind = -1;

            if (seats.Count == 2)
            {
                // special heads up rule: dealer pays the small blind
                smallBlind = seats.Single(s => s.Seat == buttonPosition).UserID;
                // the other player pays the big blind
                bigBlind = seats.Single(s => s.UserID != smallBlind).UserID;
            }
            else // get players left of dealer seat
            {
                int cursor = buttonPosition;
                while (smallBlind == -1 || bigBlind == -1)
                {
                    cursor++;
                    if (cursor > seatCount)
                        cursor = 1;

                    UserSeat nextOccupiedSeat = seats.SingleOrDefault(s => s.Seat == cursor);
                    if (nextOccupiedSeat != null)
                    {
                        if (smallBlind == -1)
                            smallBlind = nextOccupiedSeat.UserID;
                        else
                            bigBlind = nextOccupiedSeat.UserID;
                    }
                }
            }

            // insert "blinds" action
            GameAction payBlindsAction = new GameAction()
            {
                ActionTypeID = (int)ActionTypes.Blinds,
                GameID = game.ID,
                Timestamp = DateTime.Now,
                IsCommitted = true,
                Data = String.Join("|", new object[] { dealer, smallBlind, bigBlind })
            };

            ctx.GameActions.InsertOnSubmit(payBlindsAction);
            ctx.SubmitChanges(); // submit all (advance game round, button position and playBlindsAction)
        }

        public void DealPocketCards(Game game)
        {
            Console.WriteLine("Dealing pocket cards.");

            // who get's cards?
            List<int> availableCards = Enumerable.Range(1, 52).ToList();

            foreach(int userID in GetUsersInGame(game))
            {
                int card1 = GetCard(availableCards);
                int card2 = GetCard(availableCards);

                GameAction dealAction = new GameAction()
                {
                    ActionTypeID = (int)ActionTypes.InitialCards,
                    GameID = game.ID,
                    UserID = userID,
                    Timestamp = DateTime.Now,
                    IsCommitted = true,
                    Data = String.Join("|", new object[] { card1, card2 })
                };

                ctx.GameActions.InsertOnSubmit(dealAction);
            }

            ctx.SubmitChanges();
        }

        #endregion

    }

    public enum ActionTypes
    {
        UserJoined = 1,
        UserLeft = 2,
        Bet = 3,
        Raise = 4,
        Check = 5,
        Fold = 6,

        InitialCards = 7, // players 2 cards, who else got cards
        Flop = 8,
        Turn = 9,
        River = 10,
        YourTurn = 11, // player ID
        WaitForPlayers = 12,
        Blinds = 13
    };
}
