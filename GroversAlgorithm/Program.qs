namespace GroversAlgorithm {
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    
    
    @EntryPoint()
    operation Main(qubit_count : Int): Result[] {
        using (qubits = Qubit[qubit_count]) {
            SuperpositionQubits(qubits);

            for (iteration in 0..GetIterationCount(qubit_count) - 1) {
                ReflectAboutMarked(qubits);    
                ReflectAboutUniform(qubits);    
            }

            return ForEach(MResetZ, qubits);
        }
    }

    function GetIterationCount(qubit_count : Int) : Int {
        let item_count = 1 <<< qubit_count;
        let angle = ArcSin(1. / Sqrt(IntAsDouble(item_count)));
        let iteration_count = Round(0.25 * PI() / angle - 0.);
        return iteration_count;
    }
}
