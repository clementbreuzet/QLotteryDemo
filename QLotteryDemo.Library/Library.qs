namespace Quantum.QLotteryDemo.Library {

    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Logical;
    

    operation SampleLotteryDraw(maxRange: Int, draws: Int) : Int[]{
        mutable result = new Int[0];
        mutable draw = 0;

        for i in 1..draws {
            repeat{
                set draw = SampleRandomNumberInRange(maxRange);
            }
            until !IsValueInArray(draw, result);
            set result += [draw];

        }
        return result;
    }

    operation SampleRandomNumberInRange(maxRange: Int) : Int {
        mutable bits = new Result[0];

        for indexBit in 1..BitSizeI(maxRange){
            set bits += [SampleQuantumRandomNumberGenerator()];
        }

        let sample = ResultArrayAsInt(bits);

        return sample > maxRange ? SampleRandomNumberInRange(maxRange) | sample;
    }


    operation SampleQuantumRandomNumberGenerator() : Result {
        borrow q = Qubit(){
            H(q);
            return M(q);
        }
    } 

    function IsValueInArray(value: Int, array: Int[]): Bool {
        return Any(EqualI(_,value), array);
    }
}
