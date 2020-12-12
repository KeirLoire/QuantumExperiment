namespace QubitEntanglement {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation SetQubitState(desired : Result, q1 : Qubit) : Unit {
        if (desired != M(q1)) {
            X(q1);
        }
    }

    @EntryPoint()
    operation Main(count : Int, initial : Result) : Unit {
        mutable numOnes = 0;
        mutable match = 0;
        using ((q0, q1) = (Qubit(), Qubit())) {
            for (test in 1..count) {
                SetQubitState(initial, q0);
                SetQubitState(Zero, q1);

                H(q0); // Put qubit into superposition.
                CNOT(q0, q1); // Entangle two qubits.

                if (M(q1) == M(q0)) {
                    set match += 1;
                }

                if (M(q0) == One) {
                    set numOnes += 1;
                }
            }

            SetQubitState(Zero, q0);
            SetQubitState(Zero, q1);
        }

        Message($"Count for 0s: {count - numOnes}");
        Message($"Count for 1s: {numOnes}");
        Message($"Qubit matches: {match}");
    }
}
