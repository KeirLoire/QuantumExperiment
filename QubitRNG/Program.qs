namespace QubitRNG {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    
    operation GetQubitValue(): Result {
        using (qubit = Qubit()) {
            H(qubit);
            return MResetZ(qubit);
        }
    }

    operation GenerateValue(min : Int, max : Int) : Int {
        mutable bits = new Result[0];
        for(bit in 1..BitSizeI(max)) {
            set bits += [GetQubitValue()];
        }
        let range = ResultArrayAsInt(bits);
        return range > max or range < min ? GenerateValue(min, max) | range;
    }

    @EntryPoint()
    operation Main(min : Int, max : Int): Unit {
        Message($"Generating random number between {min} and {max}...");
        Message($"Generated value is {GenerateValue(min, max)}");
    }
}
