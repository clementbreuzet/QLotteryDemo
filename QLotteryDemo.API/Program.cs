using Microsoft.Quantum.Simulation.Simulators;
using System;
using System.Threading.Tasks;
using Quantum.QLotteryDemo.Library;

namespace QLotteryDemo.API
{
    class Program
    {
        static async Task Main(string[] args)
        {
            using (var qsim = new QuantumSimulator())
            {
                var lotteryDraw = await SampleLotteryDraw.Run(qsim, 49, 6);
                Console.WriteLine($"{lotteryDraw}");
            }
        }
    }
}
