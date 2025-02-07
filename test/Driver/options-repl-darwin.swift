// REQUIRES: OS=macosx

// Test LLDB detection, first in a clean environment, then in one that looks
// like the Xcode installation environment. We use hard links to make sure
// the Swift driver really thinks it's been moved.

// RUN: %empty-directory(%t/usr/bin/)
// RUN: %empty-directory(%t/usr/lib/)
// RUN: %hardlink-or-copy(from: %swift_driver_plain, to: %t/usr/bin/swift)
// RUN: %copy-plugin-support-library(%t/usr/lib/)

// RUN: %t/usr/bin/swift -repl -### | %FileCheck -check-prefix=INTEGRATED %s
// RUN: %t/usr/bin/swift -### | %FileCheck -check-prefix=INTEGRATED %s

// RUN: touch %t/usr/bin/lldb
// RUN: chmod +x %t/usr/bin/lldb
// RUN: %t/usr/bin/swift -repl -### | %FileCheck -check-prefix=LLDB %s
// RUN: %t/usr/bin/swift -### | %FileCheck -check-prefix=LLDB %s

// RUN: %empty-directory(%t/Toolchains/Test.xctoolchain/usr/bin)
// RUN: %empty-directory(%t/Toolchains/Test.xctoolchain/usr/lib)
// RUN: mv %t/usr/bin/swift %t/Toolchains/Test.xctoolchain/usr/bin/swift
// RUN: %copy-plugin-support-library(%t/Toolchains/Test.xctoolchain/usr/lib/)
// RUN: %t/Toolchains/Test.xctoolchain/usr/bin/swift -repl -### | %FileCheck -check-prefix=LLDB %s

// Clean up the test executable because hard links are expensive.
// RUN: rm -rf %t/Toolchains/Test.xctoolchain/usr/bin/swift

// swift-frontend cannot be copied to another location with bootstrapping because
// it will not find the libswiftCore library with its relative RPATH.
// UNSUPPORTED: swift_in_compiler

// CHECK-SWIFT-INVOKES-INTERPRETER: {{.*}}/swift-frontend -frontend -interpret

// INTEGRATED: swift -frontend -repl
// INTEGRATED: -module-name REPL

// LLDB: lldb{{"?}} "--repl=
// LLDB-NOT: -module-name
// LLDB-NOT: -target{{ }}
// LLDB: "
