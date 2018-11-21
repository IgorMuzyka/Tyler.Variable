
public final class VariableResolversStore {

    public typealias Resolver = () throws -> Any

    private var resolvers = [String: Resolver]()

    @discardableResult
    public func register<Name: RawRepresentable, Value: Codable>(name: Name, resolver: @escaping () -> Variable<Value>) -> VariableResolversStore
        where Name.RawValue == String
    {
        return register(name: name.rawValue, resolver: resolver)
    }

    @discardableResult
    public func register<Value: Codable>(name: String, resolver: @escaping () throws -> Variable<Value>) -> VariableResolversStore {
        resolvers[name] = resolver
        return self
    }

    public func resolve<Value>(_ variable: Variable<Value>) throws -> Variable<Value> {
        guard let name = variable.name else {
            throw VariableResolutionError.canNotResolveVariableWithoutName("\(dump(variable))")
        }

        guard let resolver = resolvers[name] else {
            throw VariableResolutionError.failedToResolveVariable("\(dump(variable))")
        }

        let resolved = try resolver()

        guard let matching = resolved as? Variable<Value> else {
            throw VariableResolutionError.resolvedVariableMismatchesVariableType("\(dump(resolved))")
        }

        return matching
    }
}

extension VariableResolversStore {

	public static var `default`: VariableResolversStore {
		return VariableResolversStore()
	}

	public static func subDefault(_ configuration: (VariableResolversStore) -> Void) -> VariableResolversStore {
		let store: VariableResolversStore = .default
		configuration(store)
		return store
	}
}
