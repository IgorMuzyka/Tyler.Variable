
public struct Variable<Value: Codable>: Codable {

    public let name: String?
    public let value: Value?

    public init(name: String?, value: Value?) {
        self.name = name
        self.value = value
    }

    public func resolve(_ pool: VariablePool) throws -> Value! {
        guard value == nil else {
            return value
        }

        return try pool.resolve(self).value
    }

    public func resolve(_ variableResolversStore: VariableResolversStore) throws -> Value! {
        guard value == nil else {
            return value
        }

        return try variableResolversStore.resolve(self).value
    }

    public func resolve(_ pair: VariableResolutionPair) throws -> Value! {
        guard value == nil else {
            return value
        }

        if let value = try? resolve(pair.store) {
            return value
        } else if let value = try? resolve(pair.pool) {
            return value
        } else {
            throw VariableResolutionError.failedToResolveVariable("\(dump(self))")
        }
    }
}

extension Variable {

    public static func `var`(name: String, value: Value? = nil) -> Variable {
        return Variable(name: name, value: value)
    }

    public static func `let`(name: String? = nil, _ value: Value) -> Variable {
        return Variable(name: name, value: value)
    }
}

public typealias VariableResolutionPair = (pool: VariablePool, store: VariableResolversStore)
