//{{SYMBOL}} -> symbol being applied
//{{function number}} -> the number of the function being called
//{{Desctiption}} -> place description of the function
//{{zig-function}} -> zig function to be called to perform check
//

//number = {{function number}}
pub const @"{{SYMBOL}}" = struct {
    pub const number = {{function number}};
    pub const inlined = signature(.@"{{SYMBOL}}", number);
    inline fn with(self: Object, other: Object, process: *Process) !Object { // {{Description}}
        if (other.untaggedI()) |untagged| {
            const result, const overflow = @{{zig-function}}(self.taggedI_noCheck(), untagged);
            if (overflow == 0)
                return Object.fromTaggedI(result, process);
        }
        return error.primitiveError;
    }
    pub fn primitive(pc: PC, sp: SP, process: *Process, context: *Context, extra: Extra) Result { // SmallInteger>>#{{SYMBOL}}
        const newSp = sp.dropPut(with(sp.next, sp.top, process) catch
            return @call(tailCall, Extra.primitiveFailed, .{ pc, sp, process, context, extra }));
        return @call(tailCall, process.check(context.npc), .{ context.tpc, newSp, process, context, Extra.fromContextData(context.contextDataPtr(sp)) });
    }
    pub fn inlinePrimitive(pc: PC, sp: SP, process: *Process, context: *Context, extra: Extra) Result {
        process.traceStack(sp, "{{SYMBOL}}");
        const receiver = sp.next;
        if (!receiver.isInt()) {
            trace("SmallInteger>>#inlinePrimitive: - {f}\n", .{receiver});
            return @call(tailCall, PC.inlinePrimitiveFailed, .{ pc, sp, process, context, extra });
        }
        const newSp = sp.dropPut(with(receiver, sp.top, process) catch
            return @call(tailCall, PC.inlinePrimitiveFailed, .{ pc, sp, process, context, extra }));
        return @call(tailCall, process.check(pc.prim2()), .{ pc.next2(), newSp, process, context, extra });
    }
};





//number = {{function number}}
pub const @"{{symbol}}" = struct {
    pub const number = {{function number}};
    pub const inlined = signature(.@"{{symbol}}", number);
    pub inline fn with(self: Object, other: Object) !bool { // {{description}}
        if (other.taggedI()) |tagged|
            return self.taggedI_noCheck() {{symbol}} tagged;
        return error.primitiveError;
    }
    pub fn primitive(pc: PC, sp: SP, process: *Process, context: *Context, extra: Extra) Result { // SmallInteger>>#{{symbol}}
        const newSp = sp.dropPut(Object.from(with(sp.next, sp.top) catch
            return @call(tailCall, Extra.primitiveFailed, .{ pc, sp, process, context, extra }), process));
        return @call(tailCall, process.check(context.npc), .{ context.tpc, newSp, process, context, Extra.fromContextData(context.contextDataPtr(sp)) });
    }
    pub fn inlinePrimitive(pc: PC, sp: SP, process: *Process, context: *Context, extra: Extra) Result {
        process.traceStack(sp, "{{symbol}}");
        const receiver = sp.next;
        if (!receiver.isInt()) {
            trace("SmallInteger>>#inlinePrimitive: <= {f}\n", .{receiver});
            return @call(tailCall, PC.inlinePrimitiveFailed, .{ pc, sp, process, context, extra });
        }
        const newSp = sp.dropPut(Object.from(with(receiver, sp.top) catch
            return @call(tailCall, PC.inlinePrimitiveFailed, .{ pc, sp, process, context, extra }), process));
        return @call(tailCall, process.check(pc.prim2()), .{ pc.next2(), newSp, process, context, extra });
    }
};
