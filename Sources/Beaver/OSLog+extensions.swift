import Foundation

extension OSLog {
    @available(macOS 10.14, iOS 12.0, watchOS 5.0, tvOS 12.0, *)
    public func signpost(type: OSSignpostType, name: StaticString, signpostID: OSSignpostID) {
        os_signpost(type, log: self, name: name, signpostID: signpostID)
    }

    @available(macOS 10.14, iOS 12.0, watchOS 5.0, tvOS 12.0, *)
    public func signpost(
        type: OSSignpostType,
        name: StaticString,
        signpostID: OSSignpostID,
        format: StaticString,
        _ args: CVarArg...
    ) {
        signpost(type: type, name: name, signpostID: signpostID, message: format, args: args)
    }

    /**
     Log a message capturing information about things that might result in a failure.

     The system's default behavior is to store the default messages in memory buffers. When the
     memory buffers are full, the system compresses those buffers and moves them to the data store.
     They remain there until a storage quota is exceeded, at which point the system purges the
     oldest messages.
     */
    public func `default`(_ message: StaticString, _ args: CVarArg...) {
        log(message, type: .default, args: args)
    }

    /**
     Log a message capturing information that may be helpful, but isn’t essential, for
     troubleshooting errors.

     The system's default behavior is to store info messages in memory buffers. The system purges
     these messages when the memory buffers are full.

     When a piece of code logs an error or fault message, the info messages are also copied to the
     data store. They remain there until a storage quota is exceeded, at which point the system
     purges the oldest messages.
     */
    public func info(_ message: StaticString, _ args: CVarArg...) {
        log(message, type: .info, args: args)
    }

    /**
     Use this level to capture verbose information that may be useful during development or while
     troubleshooting a specific problem. Debug logging is intended for use in a development
     environment and not in shipping software.

     The system's default behavior is to discard debug messages; it only captures them when you
     enable debug logging using the tools or a custom configuration.
     */
    public func debug(_ message: StaticString, _ args: CVarArg...) {
        log(message, type: .debug, args: args)
    }

    /**
     Use this level to capture information about process-level errors.

     The system always saves error messages in the data store. They remain there until a storage
     quota is exceeded, at which point the system purges the oldest messages.

     When you log an error message, the system saves other messages to the data store. If an
     activity object exists, the system captures information for the entire process chain related to
     that activity.
     */
    public func error(_ message: StaticString, _ args: CVarArg...) {
        log(message, type: .error, args: args)
    }

    /**
     Use this level only when you want to capture information about system-level or multi-process
     errors.

     The system always saves fault messages in the data store. They remain there until a storage
     quota is exceeded, at which point, the oldest messages are purged.

     When you log an fault message, the system saves other messages to the data store. If an
     activity object exists, the system captures information for the entire process chain related to
     that activity.
     */
    public func fault(_ message: StaticString, _ args: CVarArg...) {
        log(message, type: .fault, args: args)
    }

    private func log(_ message: StaticString, type: OSLogType, args: [CVarArg]) {
        switch args.count {
        case 0:
            os_log(message, log: self, type: type)
        case 1:
            os_log(message, log: self, type: type, args[0])
        case 2:
            os_log(message, log: self, type: type, args[0], args[1])
        case 3:
            os_log(message, log: self, type: type, args[0], args[1], args[2])
        default:
            assertionFailure(
                "Too many arguments passed to log. Update this to support this many arguments."
            )
            os_log(message, log: self, type: type, args[0], args[1], args[2])
        }
    }

    @available(macOS 10.14, iOS 12.0, watchOS 5.0, tvOS 12.0, *)
    private func signpost(
        type: OSSignpostType,
        name: StaticString,
        signpostID: OSSignpostID,
        message: StaticString,
        args: [CVarArg]
    ) {
        switch args.count {
        case 0:
            os_signpost(type, log: self, name: name, signpostID: signpostID)
        case 1:
            os_signpost(type, log: self, name: name, signpostID: signpostID, message, args[0])
        case 2:
            os_signpost(
                type,
                log: self,
                name: name,
                signpostID: signpostID,
                message,
                args[0],
                args[1]
            )
        case 3:
            os_signpost(
                type,
                log: self,
                name: name,
                signpostID: signpostID,
                message,
                args[0],
                args[1],
                args[2]
            )
        default:
            assertionFailure(
                "Too many arguments passed to signpost. Update this to support this many arguments."
            )
            os_signpost(
                type,
                log: self,
                name: name,
                signpostID: signpostID,
                message,
                args[0],
                args[1],
                args[2]
            )
        }
    }
}
