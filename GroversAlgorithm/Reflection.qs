namespace GroversAlgorithm {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Measurement;

    operation ReflectAboutMarked(qubits : Qubit[]) : Unit {
        using (qubit = Qubit()) {
            within {
                X(qubit);
                H(qubit);

                ApplyToEachA(X, qubits[...2...]);
            } apply {
                Controlled X(qubits, qubit);
            }
        }
    }

    operation ReflectAboutUniform(qubits : Qubit[]) : Unit {
        within {
            Adjoint SuperpositionQubits(qubits);

            FlipQubits(qubits);
        } apply {
            ReflectAboutAllOnes(qubits);
        }
    }

    operation ReflectAboutAllOnes(qubits : Qubit[]) : Unit {
        Controlled Z(Most(qubits), Tail(qubits));
    }

    operation SuperpositionQubits(qubits : Qubit[]) : Unit is Adj + Ctl {
        ApplyToEachCA(H, qubits);
    }

    operation FlipQubits(qubits : Qubit[]) : Unit is Adj + Ctl {
        ApplyToEachCA(X, qubits);
    }
}