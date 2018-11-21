
public class VariablePool { #warning("apply pool to context and make up your mind on how this would even work")

    private var pool = [String: Any]()

    public init() {}

    public func put<Value>(_ variable: Variable<Value>) -> VariablePool {
        precondition(variable.name != nil, "Can not add variable without a name")
        pool[variable.name!] = variable
        return self
    }

    public func resolve<Value>(_ variable: Variable<Value>) throws -> Variable<Value> {
        guard let name = variable.name else {
            throw VariableResolutionError.canNotResolveVariableWithoutName("\(dump(variable))")
        }

        guard let resolved = pool[name] else {
            throw VariableResolutionError.failedToResolveVariable("\(dump(variable))")
        }

        guard let matching = resolved as? Variable<Value> else {
            throw VariableResolutionError.resolvedVariableMismatchesVariableType("\(dump(resolved))")
        }

        return matching
    }
}
