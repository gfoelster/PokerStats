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
                        List<GameAction> actions = ga.OrderBy(g => g.Position).ToList();
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
            Console.WriteLine(String.Format("Game: {0}", ctx.GetGameName(gameID)));

            foreach (GameAction action in actions)
            {
                switch (action.ActionTypeID)
                {
                    case (int)ActionTypes.UserJoined : UserJoined(gameID, action); break;

                    case (int)ActionTypes.UserLeft: UserLeft(gameID, action); break;

                    default: throw new NotSupportedException(String.Format("This action (ID: {0}) is not supported.", action.ActionTypeID));
                }
            }
        }

        private static void UserLeft(int gameID, GameAction action)
        {
            throw new NotImplementedException();
        }

        private static void UserJoined(int gameID, GameAction action)
        {
            Console.WriteLine("User joined.");

            // how many users are in the game?
            int usersInGame = ctx.GetUserCountInGame(gameID);


            if (usersInGame == 0)
            {
                // wait for one more user to start
            }
            else if (usersInGame == 1)
            {
                // you are the second user, start the game
            }
            else
            {
                // game is already running, take a seat
            }
        }
    }
}
