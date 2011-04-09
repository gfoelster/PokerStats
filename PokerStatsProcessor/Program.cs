using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using PokerStatsDataAccess;

namespace PokerStatsProcessor
{
    class Program
    {
        static Thread t = null;
        static AutoResetEvent evt = new AutoResetEvent(false);
        static DataAccessProvider ctx = new DataAccessProvider();

        static void Main(string[] args)
        {
            Console.WriteLine("PokerStats Processor started...");
            Console.WriteLine("Press any key to stop.\n");

            t = new Thread(new ThreadStart(LoadActions));
            t.Start();
            
            Console.ReadLine();
            
            evt.Set();
            t.Join(5000);
            Console.WriteLine("Exiting PokerStats Processor...");
            Console.WriteLine("Byebye.");
            Thread.Sleep(3000);

        }

        private static void LoadActions()
        {
            while (true)
            {
                if (evt.WaitOne(1))
                    break;
                else
                {
                    List<GameAction> uncommittedActions = ctx.GetUncommittedActions();

                    var gameActions = (from a in uncommittedActions
                                            group a by a.GameID into games
                                            select games).ToList();

                    foreach (var ga in gameActions)
                    {
                        List<GameAction> actions = ga.OrderBy(g => g.ID).ToList();
                        if(actions.Count > 0)
                            ProcessActions(ga.Key, actions);
                    }

                    Thread.Sleep(1000);
                    //Console.WriteLine("\nProcessing completed.");
                }
            }
        }

        private static void ProcessActions(int gameID, List<GameAction> actions)
        {
            Game game = ctx.GetGameByID(gameID);

            foreach (GameAction action in actions)
            {
                Console.WriteLine(String.Format("Process Action, type: \"{0}\", game: \"{1}\"", action.ToString(), game.Name));

                switch (action.ActionTypeID)
                {
                    case (int)ActionTypes.UserJoined : UserJoined(game, action); break;

                    case (int)ActionTypes.UserLeft: UserLeft(game, action); break;

                    default: throw new NotSupportedException(String.Format("This action (ID: {0}) is not supported.", action.ActionTypeID));
                }

                Console.WriteLine();

            }

        }

        private static void UserLeft(Game game, GameAction action)
        {
        
        }

        private static void UserJoined(Game game, GameAction action)
        {
            User user = ctx.GetUserByID(action.UserID.Value);
            Console.WriteLine(String.Format("{0} joined the game.", user.Name));

            // place user, commit action
            ctx.PlaceUserOnFreeSeat(game, user, action.ID);

            // how many users are in the game?
            List<int> usersInGame = ctx.GetUsersInGame(game);

            if (usersInGame.Count == 1)
            {
                // your are the first user, wait for other players
                ctx.WaitForPlayers(game, action.UserID.Value);
            }
            if (usersInGame.Count == 2)
            {
                // you are the second user, start the game
                ctx.PayBlinds(game);

                // deal first cards
                ctx.DealPocketCards(game);
            }
            else if(usersInGame.Count > 2)
            {
                // wait for round to end
            }
        }
    }
}
