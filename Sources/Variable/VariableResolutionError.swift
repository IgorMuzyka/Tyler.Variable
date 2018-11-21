
public enum VariableResolutionError: Error {

    case canNotResolveVariableWithoutName(String)
    case failedToResolveVariable(String)
    case resolvedVariableMismatchesVariableType(String)
}
