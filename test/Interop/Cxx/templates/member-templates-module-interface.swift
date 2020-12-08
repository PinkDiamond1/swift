// RUN: %target-swift-ide-test -print-module -module-to-print=MemberTemplates -I %S/Inputs -source-filename=x -enable-cxx-interop | %FileCheck %s

// CHECK: struct HasMemberTemplates {
// CHECK:   mutating func add<T>(_ a: T, _ b: T) -> T
// CHECK:   mutating func addTwoTemplates<T, U>(_ a: T, _ b: U) -> T
// CHECK:   mutating func addAll<T, U>(_ a: Int32, _ b: T, _ c: U) -> Int32
// CHECK:   mutating func passThrough<T>(_ val: T) -> T
// CHECK:   mutating func passThroughConst<T>(_ val: T) -> T
// CHECK:   mutating func passThroughOnConst<T>(_ val: T) -> T
// CHECK:   mutating func passThroughConstOnConst<T>(_ val: T) -> T
// CHECK:   mutating func doNothingConstRef<T>(_ val: UnsafePointer<T>)
// CHECK:   mutating func make42Ref<T>(_ val: UnsafeMutablePointer<T>)
// CHECK: }

// CHECK: struct __CxxTemplateInst32TemplateClassWithMemberTemplatesIiE {
// CHECK:   var value: Int32
// CHECK:   init(_ val: Int32)
// CHECK:   mutating func setValue<U>(_ val: U)
// CHECK: }

// CHECK: typealias IntWrapper = __CxxTemplateInst32TemplateClassWithMemberTemplatesIiE