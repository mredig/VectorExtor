import Foundation
import PackagePlugin

@main
struct SIMDFixer: CommandPlugin {
	func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
		guard
			let module = context.package.sourceModules.first(where: { $0.moduleName == "VectorExtor"} )
		else { throw CustomError.error(message: "Cannot find module named 'VectorExtor'") }

		guard
			let simdDoubleSourceFile = module.sourceFiles.first(where: { $0.path.stem == "SIMD3+Double"} )
		else { throw CustomError.error(message: "Cannot find SIMD3+Double.swift")}

		let simdDoubleURL = URL(filePath: simdDoubleSourceFile.path.string)

		let simdDoubleData = try Data(contentsOf: simdDoubleURL)

		guard
			let simdDoubleString = String(data: simdDoubleData, encoding: .utf8)
		else { throw CustomError.error(message: "Cannot stringify data") }

		let simdFloatString = """
			// AUTOGENERATED FILE!
			// EDITS WILL BE OVERWRITTEN
			// TO AMEND, MAKE CHANGES TO SIMD3+Double

			\(simdDoubleString.replacingOccurrences(of: "Double", with: "Float"))
			"""

		let simdFloatURL = simdDoubleURL
			.deletingLastPathComponent()
			.appending(component: "SIMD+Float")
			.appendingPathExtension("swift")
		try simdFloatString.write(to: simdFloatURL, atomically: true, encoding: .utf8)
	}
}

enum CustomError: Error {
	case error(message: String)
}
