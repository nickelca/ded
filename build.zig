pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const exe = b.addExecutable(.{
        .name = "aa",
        .target = target,
        .optimize = optimize,
    });

    const ded = b.dependency("ded", .{});
    exe.addCSourceFiles(.{
        .root = ded.path("src/"),
        .files = &.{
            "common.c",
            "editor.c",
            "file_browser.c",
            "free_glyph.c",
            "la.c",
            "lexer.c",
            "main.c",
            "simple_renderer.c",
        },
        .flags = &.{ "-std=c11", "-pedantic" },
    });

    exe.linkLibC();
    exe.linkSystemLibrary("SDL2");
    exe.linkSystemLibrary("freetype");
    exe.linkSystemLibrary("m");
    exe.linkSystemLibrary("glew");
    exe.addIncludePath(.{ .cwd_relative = "/usr/include/freetype2" });

    b.installArtifact(exe);
}

const std = @import("std");
