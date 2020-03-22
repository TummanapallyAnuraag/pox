; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%union.anon = type { [2 x i32] }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, i32, i32 }
%struct.lpm_val = type { i8 }

@counter = global %struct.bpf_map_def { i32 2, i32 4, i32 4, i32 10, i32 0, i32 0, i32 0 }, section "maps", align 4, !dbg !0
@tx_port = global %struct.bpf_map_def { i32 14, i32 4, i32 4, i32 10, i32 0, i32 0, i32 0 }, section "maps", align 4, !dbg !22
@routes = global %struct.bpf_map_def { i32 11, i32 8, i32 1, i32 512, i32 1, i32 0, i32 0 }, section "maps", align 4, !dbg !35
@xdp_pass_func.____fmt = private unnamed_addr constant [20 x i8] c"packet received ..\0A\00", align 1
@xdp_pass_func.____fmt.1 = private unnamed_addr constant [22 x i8] c"TRIE hit!, output=%d\0A\00", align 1
@xdp_pass_func.____fmt.2 = private unnamed_addr constant [12 x i8] c"TRIE miss!\0A\00", align 1
@_license = global [4 x i8] c"GPL\00", section "license", align 1, !dbg !37
@llvm.used = appending global [5 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.bpf_map_def* @counter to i8*), i8* bitcast (%struct.bpf_map_def* @routes to i8*), i8* bitcast (%struct.bpf_map_def* @tx_port to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_pass_func to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define i32 @xdp_pass_func(%struct.xdp_md* nocapture readonly) #0 section "xdp_pass" !dbg !60 {
  %2 = alloca [20 x i8], align 1
  %3 = alloca i32, align 4
  %4 = alloca %union.anon, align 4
  %5 = alloca [22 x i8], align 1
  %6 = alloca [12 x i8], align 1
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !73, metadata !DIExpression()), !dbg !143
  %7 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !144
  %8 = load i32, i32* %7, align 4, !dbg !144, !tbaa !145
  %9 = zext i32 %8 to i64, !dbg !150
  %10 = inttoptr i64 %9 to i8*, !dbg !151
  call void @llvm.dbg.value(metadata i8* %10, metadata !74, metadata !DIExpression()), !dbg !152
  %11 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !153
  %12 = load i32, i32* %11, align 4, !dbg !153, !tbaa !154
  %13 = zext i32 %12 to i64, !dbg !155
  %14 = inttoptr i64 %13 to i8*, !dbg !156
  call void @llvm.dbg.value(metadata i8* %14, metadata !75, metadata !DIExpression()), !dbg !157
  %15 = inttoptr i64 %9 to %struct.ethhdr*, !dbg !158
  call void @llvm.dbg.value(metadata %struct.ethhdr* %15, metadata !76, metadata !DIExpression()), !dbg !159
  %16 = getelementptr i8, i8* %10, i64 14, !dbg !160
  %17 = icmp ugt i8* %16, %14, !dbg !162
  br i1 %17, label %68, label %18, !dbg !163

; <label>:18:                                     ; preds = %1
  %19 = getelementptr inbounds [20 x i8], [20 x i8]* %2, i64 0, i64 0, !dbg !164
  call void @llvm.lifetime.start.p0i8(i64 20, i8* nonnull %19) #3, !dbg !164
  call void @llvm.dbg.declare(metadata [20 x i8]* %2, metadata !88, metadata !DIExpression()), !dbg !164
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %19, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @xdp_pass_func.____fmt, i64 0, i64 0), i64 20, i32 1, i1 false), !dbg !164
  %20 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %19, i32 20) #3, !dbg !164
  call void @llvm.lifetime.end.p0i8(i64 20, i8* nonnull %19) #3, !dbg !165
  %21 = bitcast i32* %3 to i8*, !dbg !166
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %21) #3, !dbg !166
  call void @llvm.dbg.value(metadata i32 0, metadata !93, metadata !DIExpression()), !dbg !167
  store i32 0, i32* %3, align 4, !dbg !167, !tbaa !168
  %22 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @counter to i8*), i8* nonnull %21) #3, !dbg !169
  %23 = bitcast i8* %22 to i32*, !dbg !169
  call void @llvm.dbg.value(metadata i32* %23, metadata !94, metadata !DIExpression()), !dbg !170
  %24 = icmp eq i8* %22, null, !dbg !171
  br i1 %24, label %28, label %25, !dbg !173

; <label>:25:                                     ; preds = %18
  %26 = load i32, i32* %23, align 4, !dbg !174, !tbaa !168
  %27 = add nsw i32 %26, 1, !dbg !174
  store i32 %27, i32* %23, align 4, !dbg !174, !tbaa !168
  br label %28, !dbg !175

; <label>:28:                                     ; preds = %18, %25
  %29 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 2, !dbg !176
  %30 = load i16, i16* %29, align 1, !dbg !176, !tbaa !178
  %31 = icmp eq i16 %30, 8, !dbg !181
  br i1 %31, label %32, label %67, !dbg !182

; <label>:32:                                     ; preds = %28
  call void @llvm.dbg.value(metadata i8* %16, metadata !96, metadata !DIExpression()), !dbg !183
  %33 = getelementptr inbounds i8, i8* %10, i64 414, !dbg !184
  %34 = bitcast i8* %33 to %struct.iphdr*, !dbg !184
  %35 = inttoptr i64 %13 to %struct.iphdr*, !dbg !186
  %36 = icmp ugt %struct.iphdr* %34, %35, !dbg !187
  br i1 %36, label %67, label %37, !dbg !188

; <label>:37:                                     ; preds = %32
  %38 = getelementptr inbounds i8, i8* %10, i64 30, !dbg !189
  %39 = bitcast i8* %38 to i32*, !dbg !189
  %40 = load i32, i32* %39, align 4, !dbg !189, !tbaa !190
  call void @llvm.dbg.value(metadata i32 %40, metadata !115, metadata !DIExpression()), !dbg !192
  %41 = bitcast %union.anon* %4 to i8*, !dbg !193
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %41) #3, !dbg !193
  call void @llvm.dbg.value(metadata %struct.lpm_val* null, metadata !127, metadata !DIExpression()), !dbg !194
  %42 = getelementptr inbounds %union.anon, %union.anon* %4, i64 0, i32 0, i64 0, !dbg !195
  store i32 32, i32* %42, align 4, !dbg !196, !tbaa !197
  %43 = trunc i32 %40 to i8, !dbg !198
  %44 = bitcast %union.anon* %4 to [8 x i8]*, !dbg !199
  %45 = getelementptr inbounds %union.anon, %union.anon* %4, i64 0, i32 0, i64 1, !dbg !200
  %46 = bitcast i32* %45 to i8*, !dbg !200
  store i8 %43, i8* %46, align 4, !dbg !201, !tbaa !197
  %47 = lshr i32 %40, 8, !dbg !202
  %48 = trunc i32 %47 to i8, !dbg !203
  %49 = getelementptr inbounds [8 x i8], [8 x i8]* %44, i64 0, i64 5, !dbg !204
  store i8 %48, i8* %49, align 1, !dbg !205, !tbaa !197
  %50 = lshr i32 %40, 16, !dbg !206
  %51 = trunc i32 %50 to i8, !dbg !207
  %52 = getelementptr inbounds [8 x i8], [8 x i8]* %44, i64 0, i64 6, !dbg !208
  store i8 %51, i8* %52, align 2, !dbg !209, !tbaa !197
  %53 = lshr i32 %40, 24, !dbg !210
  %54 = trunc i32 %53 to i8, !dbg !211
  %55 = getelementptr inbounds [8 x i8], [8 x i8]* %44, i64 0, i64 7, !dbg !212
  store i8 %54, i8* %55, align 1, !dbg !213, !tbaa !197
  %56 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @routes to i8*), i8* nonnull %41) #3, !dbg !214
  call void @llvm.dbg.value(metadata i8* %56, metadata !127, metadata !DIExpression()), !dbg !194
  %57 = icmp eq i8* %56, null, !dbg !215
  br i1 %57, label %63, label %58, !dbg !216

; <label>:58:                                     ; preds = %37
  %59 = getelementptr inbounds [22 x i8], [22 x i8]* %5, i64 0, i64 0, !dbg !217
  call void @llvm.lifetime.start.p0i8(i64 22, i8* nonnull %59) #3, !dbg !217
  call void @llvm.dbg.declare(metadata [22 x i8]* %5, metadata !132, metadata !DIExpression()), !dbg !217
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %59, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @xdp_pass_func.____fmt.1, i64 0, i64 0), i64 22, i32 1, i1 false), !dbg !217
  %60 = load i8, i8* %56, align 1, !dbg !217, !tbaa !218
  %61 = zext i8 %60 to i32, !dbg !217
  %62 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %59, i32 22, i32 %61) #3, !dbg !217
  call void @llvm.lifetime.end.p0i8(i64 22, i8* nonnull %59) #3, !dbg !220
  br label %66, !dbg !220

; <label>:63:                                     ; preds = %37
  %64 = getelementptr inbounds [12 x i8], [12 x i8]* %6, i64 0, i64 0, !dbg !221
  call void @llvm.lifetime.start.p0i8(i64 12, i8* nonnull %64) #3, !dbg !221
  call void @llvm.dbg.declare(metadata [12 x i8]* %6, metadata !138, metadata !DIExpression()), !dbg !221
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %64, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @xdp_pass_func.____fmt.2, i64 0, i64 0), i64 12, i32 1, i1 false), !dbg !221
  %65 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %64, i32 12) #3, !dbg !221
  call void @llvm.lifetime.end.p0i8(i64 12, i8* nonnull %64) #3, !dbg !222
  br label %66

; <label>:66:                                     ; preds = %63, %58
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %41) #3, !dbg !223
  br label %67

; <label>:67:                                     ; preds = %66, %32, %28
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %21) #3, !dbg !223
  br label %68

; <label>:68:                                     ; preds = %1, %67
  ret i32 2, !dbg !223
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #2

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!56, !57, !58}
!llvm.ident = !{!59}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "counter", scope: !2, file: !3, line: 23, type: !24, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !13, globals: !21)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/anuraag/IITB/Sem6/router-src/_switch/scripts/bpfcode")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, size: 32, elements: !7)
!6 = !DIFile(filename: "../includes/headers/linux/bpf.h", directory: "/home/anuraag/IITB/Sem6/router-src/_switch/scripts/bpfcode")
!7 = !{!8, !9, !10, !11, !12}
!8 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!9 = !DIEnumerator(name: "XDP_DROP", value: 1)
!10 = !DIEnumerator(name: "XDP_PASS", value: 2)
!11 = !DIEnumerator(name: "XDP_TX", value: 3)
!12 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!13 = !{!14, !15, !16, !18}
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!15 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !17, line: 25, baseType: !18)
!17 = !DIFile(filename: "/usr/include/linux/types.h", directory: "/home/anuraag/IITB/Sem6/router-src/_switch/scripts/bpfcode")
!18 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !19, line: 24, baseType: !20)
!19 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "/home/anuraag/IITB/Sem6/router-src/_switch/scripts/bpfcode")
!20 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!21 = !{!0, !22, !35, !37, !43, !51}
!22 = !DIGlobalVariableExpression(var: !23, expr: !DIExpression())
!23 = distinct !DIGlobalVariable(name: "tx_port", scope: !2, file: !3, line: 31, type: !24, isLocal: false, isDefinition: true)
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !25, line: 210, size: 224, elements: !26)
!25 = !DIFile(filename: "../includes/headers/bpf_helpers.h", directory: "/home/anuraag/IITB/Sem6/router-src/_switch/scripts/bpfcode")
!26 = !{!27, !29, !30, !31, !32, !33, !34}
!27 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !24, file: !25, line: 211, baseType: !28, size: 32)
!28 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !24, file: !25, line: 212, baseType: !28, size: 32, offset: 32)
!30 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !24, file: !25, line: 213, baseType: !28, size: 32, offset: 64)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !24, file: !25, line: 214, baseType: !28, size: 32, offset: 96)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !24, file: !25, line: 215, baseType: !28, size: 32, offset: 128)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "inner_map_idx", scope: !24, file: !25, line: 216, baseType: !28, size: 32, offset: 160)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "numa_node", scope: !24, file: !25, line: 217, baseType: !28, size: 32, offset: 192)
!35 = !DIGlobalVariableExpression(var: !36, expr: !DIExpression())
!36 = distinct !DIGlobalVariable(name: "routes", scope: !2, file: !3, line: 48, type: !24, isLocal: false, isDefinition: true)
!37 = !DIGlobalVariableExpression(var: !38, expr: !DIExpression())
!38 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 140, type: !39, isLocal: false, isDefinition: true)
!39 = !DICompositeType(tag: DW_TAG_array_type, baseType: !40, size: 32, elements: !41)
!40 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!41 = !{!42}
!42 = !DISubrange(count: 4)
!43 = !DIGlobalVariableExpression(var: !44, expr: !DIExpression())
!44 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !25, line: 38, type: !45, isLocal: true, isDefinition: true)
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !46, size: 64)
!46 = !DISubroutineType(types: !47)
!47 = !{!48, !49, !48, null}
!48 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!49 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !50, size: 64)
!50 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !40)
!51 = !DIGlobalVariableExpression(var: !52, expr: !DIExpression())
!52 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !25, line: 20, type: !53, isLocal: true, isDefinition: true)
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !54, size: 64)
!54 = !DISubroutineType(types: !55)
!55 = !{!14, !14, !14}
!56 = !{i32 2, !"Dwarf Version", i32 4}
!57 = !{i32 2, !"Debug Info Version", i32 3}
!58 = !{i32 1, !"wchar_size", i32 4}
!59 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
!60 = distinct !DISubprogram(name: "xdp_pass_func", scope: !3, file: !3, line: 58, type: !61, isLocal: false, isDefinition: true, scopeLine: 59, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !72)
!61 = !DISubroutineType(types: !62)
!62 = !{!48, !63}
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !64, size: 64)
!64 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !65)
!65 = !{!66, !68, !69, !70, !71}
!66 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !64, file: !6, line: 2857, baseType: !67, size: 32)
!67 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !19, line: 27, baseType: !28)
!68 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !64, file: !6, line: 2858, baseType: !67, size: 32, offset: 32)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !64, file: !6, line: 2859, baseType: !67, size: 32, offset: 64)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !64, file: !6, line: 2861, baseType: !67, size: 32, offset: 96)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !64, file: !6, line: 2862, baseType: !67, size: 32, offset: 128)
!72 = !{!73, !74, !75, !76, !88, !93, !94, !96, !115, !116, !127, !132, !138}
!73 = !DILocalVariable(name: "ctx", arg: 1, scope: !60, file: !3, line: 58, type: !63)
!74 = !DILocalVariable(name: "data", scope: !60, file: !3, line: 60, type: !14)
!75 = !DILocalVariable(name: "data_end", scope: !60, file: !3, line: 61, type: !14)
!76 = !DILocalVariable(name: "eth", scope: !60, file: !3, line: 62, type: !77)
!77 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !78, size: 64)
!78 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !79, line: 159, size: 112, elements: !80)
!79 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "/home/anuraag/IITB/Sem6/router-src/_switch/scripts/bpfcode")
!80 = !{!81, !86, !87}
!81 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !78, file: !79, line: 160, baseType: !82, size: 48)
!82 = !DICompositeType(tag: DW_TAG_array_type, baseType: !83, size: 48, elements: !84)
!83 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!84 = !{!85}
!85 = !DISubrange(count: 6)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !78, file: !79, line: 161, baseType: !82, size: 48, offset: 48)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !78, file: !79, line: 162, baseType: !16, size: 16, offset: 96)
!88 = !DILocalVariable(name: "____fmt", scope: !89, file: !3, line: 69, type: !90)
!89 = distinct !DILexicalBlock(scope: !60, file: !3, line: 69, column: 2)
!90 = !DICompositeType(tag: DW_TAG_array_type, baseType: !40, size: 160, elements: !91)
!91 = !{!92}
!92 = !DISubrange(count: 20)
!93 = !DILocalVariable(name: "int_key", scope: !60, file: !3, line: 70, type: !48)
!94 = !DILocalVariable(name: "int_val", scope: !60, file: !3, line: 71, type: !95)
!95 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!96 = !DILocalVariable(name: "ip", scope: !60, file: !3, line: 80, type: !97)
!97 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !98, size: 64)
!98 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !99, line: 86, size: 160, elements: !100)
!99 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "/home/anuraag/IITB/Sem6/router-src/_switch/scripts/bpfcode")
!100 = !{!101, !103, !104, !105, !106, !107, !108, !109, !110, !112, !114}
!101 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !98, file: !99, line: 88, baseType: !102, size: 4, flags: DIFlagBitField, extraData: i64 0)
!102 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !19, line: 21, baseType: !83)
!103 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !98, file: !99, line: 89, baseType: !102, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!104 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !98, file: !99, line: 96, baseType: !102, size: 8, offset: 8)
!105 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !98, file: !99, line: 97, baseType: !16, size: 16, offset: 16)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !98, file: !99, line: 98, baseType: !16, size: 16, offset: 32)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !98, file: !99, line: 99, baseType: !16, size: 16, offset: 48)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !98, file: !99, line: 100, baseType: !102, size: 8, offset: 64)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !98, file: !99, line: 101, baseType: !102, size: 8, offset: 72)
!110 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !98, file: !99, line: 102, baseType: !111, size: 16, offset: 80)
!111 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !17, line: 31, baseType: !18)
!112 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !98, file: !99, line: 103, baseType: !113, size: 32, offset: 96)
!113 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !17, line: 27, baseType: !67)
!114 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !98, file: !99, line: 104, baseType: !113, size: 32, offset: 128)
!115 = !DILocalVariable(name: "dst_ip", scope: !60, file: !3, line: 85, type: !67)
!116 = !DILocalVariable(name: "key4", scope: !60, file: !3, line: 91, type: !117)
!117 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !60, file: !3, line: 88, size: 64, elements: !118)
!118 = !{!119, !123}
!119 = !DIDerivedType(tag: DW_TAG_member, name: "b32", scope: !117, file: !3, line: 89, baseType: !120, size: 64)
!120 = !DICompositeType(tag: DW_TAG_array_type, baseType: !67, size: 64, elements: !121)
!121 = !{!122}
!122 = !DISubrange(count: 2)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "b8", scope: !117, file: !3, line: 90, baseType: !124, size: 64)
!124 = !DICompositeType(tag: DW_TAG_array_type, baseType: !102, size: 64, elements: !125)
!125 = !{!126}
!126 = !DISubrange(count: 8)
!127 = !DILocalVariable(name: "val", scope: !60, file: !3, line: 92, type: !128)
!128 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !129, size: 64)
!129 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "lpm_val", file: !3, line: 43, size: 8, elements: !130)
!130 = !{!131}
!131 = !DIDerivedType(tag: DW_TAG_member, name: "flags", scope: !129, file: !3, line: 44, baseType: !102, size: 8)
!132 = !DILocalVariable(name: "____fmt", scope: !133, file: !3, line: 114, type: !135)
!133 = distinct !DILexicalBlock(scope: !134, file: !3, line: 114, column: 9)
!134 = distinct !DILexicalBlock(scope: !60, file: !3, line: 113, column: 8)
!135 = !DICompositeType(tag: DW_TAG_array_type, baseType: !40, size: 176, elements: !136)
!136 = !{!137}
!137 = !DISubrange(count: 22)
!138 = !DILocalVariable(name: "____fmt", scope: !139, file: !3, line: 116, type: !140)
!139 = distinct !DILexicalBlock(scope: !134, file: !3, line: 116, column: 3)
!140 = !DICompositeType(tag: DW_TAG_array_type, baseType: !40, size: 96, elements: !141)
!141 = !{!142}
!142 = !DISubrange(count: 12)
!143 = !DILocation(line: 58, column: 35, scope: !60)
!144 = !DILocation(line: 60, column: 34, scope: !60)
!145 = !{!146, !147, i64 0}
!146 = !{!"xdp_md", !147, i64 0, !147, i64 4, !147, i64 8, !147, i64 12, !147, i64 16}
!147 = !{!"int", !148, i64 0}
!148 = !{!"omnipotent char", !149, i64 0}
!149 = !{!"Simple C/C++ TBAA"}
!150 = !DILocation(line: 60, column: 23, scope: !60)
!151 = !DILocation(line: 60, column: 15, scope: !60)
!152 = !DILocation(line: 60, column: 8, scope: !60)
!153 = !DILocation(line: 61, column: 38, scope: !60)
!154 = !{!146, !147, i64 4}
!155 = !DILocation(line: 61, column: 27, scope: !60)
!156 = !DILocation(line: 61, column: 19, scope: !60)
!157 = !DILocation(line: 61, column: 8, scope: !60)
!158 = !DILocation(line: 62, column: 23, scope: !60)
!159 = !DILocation(line: 62, column: 17, scope: !60)
!160 = !DILocation(line: 65, column: 11, scope: !161)
!161 = distinct !DILexicalBlock(scope: !60, file: !3, line: 65, column: 6)
!162 = !DILocation(line: 65, column: 35, scope: !161)
!163 = !DILocation(line: 65, column: 6, scope: !60)
!164 = !DILocation(line: 69, column: 2, scope: !89)
!165 = !DILocation(line: 69, column: 2, scope: !60)
!166 = !DILocation(line: 70, column: 5, scope: !60)
!167 = !DILocation(line: 70, column: 9, scope: !60)
!168 = !{!147, !147, i64 0}
!169 = !DILocation(line: 72, column: 15, scope: !60)
!170 = !DILocation(line: 71, column: 10, scope: !60)
!171 = !DILocation(line: 73, column: 8, scope: !172)
!172 = distinct !DILexicalBlock(scope: !60, file: !3, line: 73, column: 8)
!173 = !DILocation(line: 73, column: 8, scope: !60)
!174 = !DILocation(line: 74, column: 19, scope: !172)
!175 = !DILocation(line: 74, column: 9, scope: !172)
!176 = !DILocation(line: 77, column: 11, scope: !177)
!177 = distinct !DILexicalBlock(scope: !60, file: !3, line: 77, column: 6)
!178 = !{!179, !180, i64 12}
!179 = !{!"ethhdr", !148, i64 0, !148, i64 6, !180, i64 12}
!180 = !{!"short", !148, i64 0}
!181 = !DILocation(line: 77, column: 19, scope: !177)
!182 = !DILocation(line: 77, column: 6, scope: !60)
!183 = !DILocation(line: 80, column: 21, scope: !60)
!184 = !DILocation(line: 82, column: 8, scope: !185)
!185 = distinct !DILexicalBlock(scope: !60, file: !3, line: 82, column: 5)
!186 = !DILocation(line: 82, column: 33, scope: !185)
!187 = !DILocation(line: 82, column: 31, scope: !185)
!188 = !DILocation(line: 82, column: 5, scope: !60)
!189 = !DILocation(line: 85, column: 21, scope: !60)
!190 = !{!191, !147, i64 16}
!191 = !{!"iphdr", !148, i64 0, !148, i64 0, !148, i64 1, !180, i64 2, !180, i64 4, !180, i64 6, !148, i64 8, !148, i64 9, !180, i64 10, !147, i64 12, !147, i64 16}
!192 = !DILocation(line: 85, column: 8, scope: !60)
!193 = !DILocation(line: 88, column: 2, scope: !60)
!194 = !DILocation(line: 92, column: 21, scope: !60)
!195 = !DILocation(line: 100, column: 2, scope: !60)
!196 = !DILocation(line: 100, column: 14, scope: !60)
!197 = !{!148, !148, i64 0}
!198 = !DILocation(line: 101, column: 15, scope: !60)
!199 = !DILocation(line: 101, column: 7, scope: !60)
!200 = !DILocation(line: 101, column: 2, scope: !60)
!201 = !DILocation(line: 101, column: 13, scope: !60)
!202 = !DILocation(line: 102, column: 23, scope: !60)
!203 = !DILocation(line: 102, column: 15, scope: !60)
!204 = !DILocation(line: 102, column: 2, scope: !60)
!205 = !DILocation(line: 102, column: 13, scope: !60)
!206 = !DILocation(line: 103, column: 23, scope: !60)
!207 = !DILocation(line: 103, column: 15, scope: !60)
!208 = !DILocation(line: 103, column: 2, scope: !60)
!209 = !DILocation(line: 103, column: 13, scope: !60)
!210 = !DILocation(line: 104, column: 23, scope: !60)
!211 = !DILocation(line: 104, column: 15, scope: !60)
!212 = !DILocation(line: 104, column: 2, scope: !60)
!213 = !DILocation(line: 104, column: 13, scope: !60)
!214 = !DILocation(line: 112, column: 11, scope: !60)
!215 = !DILocation(line: 113, column: 8, scope: !134)
!216 = !DILocation(line: 113, column: 8, scope: !60)
!217 = !DILocation(line: 114, column: 9, scope: !133)
!218 = !{!219, !148, i64 0}
!219 = !{!"lpm_val", !148, i64 0}
!220 = !DILocation(line: 114, column: 9, scope: !134)
!221 = !DILocation(line: 116, column: 3, scope: !139)
!222 = !DILocation(line: 116, column: 3, scope: !134)
!223 = !DILocation(line: 138, column: 1, scope: !60)
