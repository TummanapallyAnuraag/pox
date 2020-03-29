; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%union.anon = type { [2 x i32] }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, i32, i32 }
%struct.lpm_val = type { [6 x i8], i8 }

@counter = global %struct.bpf_map_def { i32 2, i32 4, i32 4, i32 10, i32 0, i32 0, i32 0 }, section "maps", align 4, !dbg !0
@tx_port = global %struct.bpf_map_def { i32 14, i32 4, i32 4, i32 10, i32 0, i32 0, i32 0 }, section "maps", align 4, !dbg !22
@sw_nics = global %struct.bpf_map_def { i32 2, i32 4, i32 6, i32 10, i32 0, i32 0, i32 0 }, section "maps", align 4, !dbg !35
@routes = global %struct.bpf_map_def { i32 11, i32 8, i32 7, i32 512, i32 1, i32 0, i32 0 }, section "maps", align 4, !dbg !37
@xdp_pass_func.____fmt = private unnamed_addr constant [22 x i8] c"TRIE hit!, output=%d\0A\00", align 1
@xdp_pass_func.____fmt.1 = private unnamed_addr constant [20 x i8] c"Iface MAC Addr: %s\0A\00", align 1
@xdp_pass_func.____fmt.2 = private unnamed_addr constant [17 x i8] c"TRIE miss for..\0A\00", align 1
@_license = global [4 x i8] c"GPL\00", section "license", align 1, !dbg !39
@llvm.used = appending global [6 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.bpf_map_def* @counter to i8*), i8* bitcast (%struct.bpf_map_def* @routes to i8*), i8* bitcast (%struct.bpf_map_def* @sw_nics to i8*), i8* bitcast (%struct.bpf_map_def* @tx_port to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_pass_func to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define i32 @xdp_pass_func(%struct.xdp_md* nocapture readonly) #0 section "xdp_pass" !dbg !62 {
  %2 = alloca i32, align 4
  %3 = alloca %union.anon, align 4
  %4 = alloca [22 x i8], align 1
  %5 = alloca i32, align 4
  %6 = alloca [30 x i8], align 1
  %7 = alloca [20 x i8], align 1
  %8 = alloca [17 x i8], align 1
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !75, metadata !DIExpression()), !dbg !169
  %13 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !170
  %14 = load i32, i32* %13, align 4, !dbg !170, !tbaa !171
  %15 = zext i32 %14 to i64, !dbg !176
  %16 = inttoptr i64 %15 to i8*, !dbg !177
  call void @llvm.dbg.value(metadata i8* %16, metadata !76, metadata !DIExpression()), !dbg !178
  %17 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !179
  %18 = load i32, i32* %17, align 4, !dbg !179, !tbaa !180
  %19 = zext i32 %18 to i64, !dbg !181
  %20 = inttoptr i64 %19 to i8*, !dbg !182
  call void @llvm.dbg.value(metadata i8* %20, metadata !77, metadata !DIExpression()), !dbg !183
  %21 = inttoptr i64 %15 to %struct.ethhdr*, !dbg !184
  call void @llvm.dbg.value(metadata %struct.ethhdr* %21, metadata !78, metadata !DIExpression()), !dbg !185
  %22 = getelementptr i8, i8* %16, i64 14, !dbg !186
  %23 = icmp ugt i8* %22, %20, !dbg !188
  br i1 %23, label %215, label %24, !dbg !189

; <label>:24:                                     ; preds = %1
  %25 = bitcast i32* %2 to i8*, !dbg !190
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %25) #3, !dbg !190
  call void @llvm.dbg.value(metadata i32 0, metadata !90, metadata !DIExpression()), !dbg !191
  store i32 0, i32* %2, align 4, !dbg !191, !tbaa !192
  %26 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @counter to i8*), i8* nonnull %25) #3, !dbg !193
  %27 = bitcast i8* %26 to i32*, !dbg !193
  call void @llvm.dbg.value(metadata i32* %27, metadata !91, metadata !DIExpression()), !dbg !194
  %28 = icmp eq i8* %26, null, !dbg !195
  br i1 %28, label %32, label %29, !dbg !197

; <label>:29:                                     ; preds = %24
  %30 = load i32, i32* %27, align 4, !dbg !198, !tbaa !192
  %31 = add nsw i32 %30, 1, !dbg !198
  store i32 %31, i32* %27, align 4, !dbg !198, !tbaa !192
  br label %32, !dbg !200

; <label>:32:                                     ; preds = %24, %29
  %33 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %21, i64 0, i32 2, !dbg !201
  %34 = load i16, i16* %33, align 1, !dbg !201, !tbaa !203
  %35 = icmp eq i16 %34, 8, !dbg !206
  br i1 %35, label %36, label %214, !dbg !207

; <label>:36:                                     ; preds = %32
  call void @llvm.dbg.value(metadata i8* %22, metadata !93, metadata !DIExpression()), !dbg !208
  %37 = getelementptr inbounds i8, i8* %16, i64 414, !dbg !209
  %38 = bitcast i8* %37 to %struct.iphdr*, !dbg !209
  %39 = inttoptr i64 %19 to %struct.iphdr*, !dbg !211
  %40 = icmp ugt %struct.iphdr* %38, %39, !dbg !212
  br i1 %40, label %214, label %41, !dbg !213

; <label>:41:                                     ; preds = %36
  %42 = getelementptr inbounds i8, i8* %16, i64 30, !dbg !214
  %43 = bitcast i8* %42 to i32*, !dbg !214
  %44 = load i32, i32* %43, align 4, !dbg !214, !tbaa !215
  call void @llvm.dbg.value(metadata i32 %44, metadata !112, metadata !DIExpression()), !dbg !217
  %45 = bitcast %union.anon* %3 to i8*, !dbg !218
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %45) #3, !dbg !218
  call void @llvm.dbg.value(metadata %struct.lpm_val* null, metadata !124, metadata !DIExpression()), !dbg !219
  %46 = getelementptr inbounds %union.anon, %union.anon* %3, i64 0, i32 0, i64 0, !dbg !220
  store i32 32, i32* %46, align 4, !dbg !221, !tbaa !222
  %47 = trunc i32 %44 to i8, !dbg !223
  %48 = bitcast %union.anon* %3 to [8 x i8]*, !dbg !224
  %49 = getelementptr inbounds %union.anon, %union.anon* %3, i64 0, i32 0, i64 1, !dbg !225
  %50 = bitcast i32* %49 to i8*, !dbg !225
  store i8 %47, i8* %50, align 4, !dbg !226, !tbaa !222
  %51 = lshr i32 %44, 8, !dbg !227
  %52 = trunc i32 %51 to i8, !dbg !228
  %53 = getelementptr inbounds [8 x i8], [8 x i8]* %48, i64 0, i64 5, !dbg !229
  store i8 %52, i8* %53, align 1, !dbg !230, !tbaa !222
  %54 = lshr i32 %44, 16, !dbg !231
  %55 = trunc i32 %54 to i8, !dbg !232
  %56 = getelementptr inbounds [8 x i8], [8 x i8]* %48, i64 0, i64 6, !dbg !233
  store i8 %55, i8* %56, align 2, !dbg !234, !tbaa !222
  %57 = lshr i32 %44, 24, !dbg !235
  %58 = trunc i32 %57 to i8, !dbg !236
  %59 = getelementptr inbounds [8 x i8], [8 x i8]* %48, i64 0, i64 7, !dbg !237
  store i8 %58, i8* %59, align 1, !dbg !238, !tbaa !222
  %60 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @routes to i8*), i8* nonnull %45) #3, !dbg !239
  call void @llvm.dbg.value(metadata i8* %60, metadata !124, metadata !DIExpression()), !dbg !219
  %61 = icmp eq i8* %60, null, !dbg !240
  br i1 %61, label %194, label %62, !dbg !241

; <label>:62:                                     ; preds = %41
  %63 = getelementptr inbounds [22 x i8], [22 x i8]* %4, i64 0, i64 0, !dbg !242
  call void @llvm.lifetime.start.p0i8(i64 22, i8* nonnull %63) #3, !dbg !242
  call void @llvm.dbg.declare(metadata [22 x i8]* %4, metadata !131, metadata !DIExpression()), !dbg !242
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %63, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @xdp_pass_func.____fmt, i64 0, i64 0), i64 22, i32 1, i1 false), !dbg !242
  %64 = getelementptr inbounds i8, i8* %60, i64 6, !dbg !242
  %65 = load i8, i8* %64, align 1, !dbg !242, !tbaa !243
  %66 = zext i8 %65 to i32, !dbg !242
  %67 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %63, i32 22, i32 %66) #3, !dbg !242
  call void @llvm.lifetime.end.p0i8(i64 22, i8* nonnull %63) #3, !dbg !245
  %68 = bitcast i32* %5 to i8*, !dbg !246
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %68) #3, !dbg !246
  call void @llvm.dbg.value(metadata i32 3, metadata !138, metadata !DIExpression()), !dbg !247
  store i32 3, i32* %5, align 4, !dbg !247, !tbaa !192
  %69 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @sw_nics to i8*), i8* nonnull %68) #3, !dbg !248
  call void @llvm.dbg.value(metadata i8* %69, metadata !139, metadata !DIExpression()), !dbg !249
  %70 = icmp eq i8* %69, null, !dbg !250
  br i1 %70, label %193, label %71, !dbg !251

; <label>:71:                                     ; preds = %62
  %72 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 0, !dbg !252
  call void @llvm.lifetime.start.p0i8(i64 30, i8* nonnull %72) #3, !dbg !252
  call void @llvm.dbg.declare(metadata [30 x i8]* %6, metadata !141, metadata !DIExpression()), !dbg !253
  call void @llvm.dbg.value(metadata i32 0, metadata !147, metadata !DIExpression()), !dbg !254
  call void @llvm.dbg.value(metadata i32 0, metadata !148, metadata !DIExpression()), !dbg !255
  call void @llvm.dbg.value(metadata i64 0, metadata !148, metadata !DIExpression()), !dbg !255
  call void @llvm.dbg.value(metadata i32 0, metadata !147, metadata !DIExpression()), !dbg !254
  %73 = load i8, i8* %69, align 1, !dbg !256, !tbaa !222
  %74 = zext i8 %73 to i32, !dbg !256
  %75 = lshr i32 %74, 4, !dbg !260
  %76 = icmp ugt i8 %73, -97, !dbg !261
  %77 = or i32 %75, 48, !dbg !262
  %78 = add nuw nsw i32 %75, 55, !dbg !264
  %79 = select i1 %76, i32 %78, i32 %77, !dbg !266
  %80 = trunc i32 %79 to i8
  store i8 %80, i8* %72, align 1, !dbg !267
  call void @llvm.dbg.value(metadata i32 1, metadata !147, metadata !DIExpression()), !dbg !254
  %81 = load i8, i8* %69, align 1, !dbg !268, !tbaa !222
  %82 = and i8 %81, 15, !dbg !270
  %83 = zext i8 %82 to i32, !dbg !270
  %84 = icmp ugt i8 %82, 9, !dbg !271
  %85 = or i32 %83, 48, !dbg !272
  %86 = add nuw nsw i32 %83, 55, !dbg !274
  %87 = select i1 %84, i32 %86, i32 %85, !dbg !276
  %88 = trunc i32 %87 to i8
  %89 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 1, !dbg !277
  store i8 %88, i8* %89, align 1, !dbg !278
  call void @llvm.dbg.value(metadata i32 2, metadata !147, metadata !DIExpression()), !dbg !254
  %90 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 2, !dbg !279
  store i8 58, i8* %90, align 1, !dbg !282, !tbaa !222
  call void @llvm.dbg.value(metadata i32 2, metadata !147, metadata !DIExpression()), !dbg !254
  call void @llvm.dbg.value(metadata i32 3, metadata !147, metadata !DIExpression()), !dbg !254
  call void @llvm.dbg.value(metadata i64 1, metadata !148, metadata !DIExpression()), !dbg !255
  call void @llvm.dbg.value(metadata i32 3, metadata !147, metadata !DIExpression()), !dbg !254
  %91 = getelementptr inbounds i8, i8* %69, i64 1, !dbg !256
  %92 = load i8, i8* %91, align 1, !dbg !256, !tbaa !222
  %93 = zext i8 %92 to i32, !dbg !256
  %94 = lshr i32 %93, 4, !dbg !260
  %95 = icmp ugt i8 %92, -97, !dbg !261
  %96 = add nuw nsw i32 %94, 55, !dbg !264
  %97 = or i32 %94, 48, !dbg !262
  %98 = select i1 %95, i32 %96, i32 %97, !dbg !266
  %99 = trunc i32 %98 to i8
  %100 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 3
  store i8 %99, i8* %100, align 1, !tbaa !222
  call void @llvm.dbg.value(metadata i32 4, metadata !147, metadata !DIExpression()), !dbg !254
  %101 = load i8, i8* %91, align 1, !dbg !268, !tbaa !222
  %102 = and i8 %101, 15, !dbg !270
  %103 = zext i8 %102 to i32, !dbg !270
  %104 = icmp ugt i8 %102, 9, !dbg !271
  %105 = add nuw nsw i32 %103, 55, !dbg !274
  %106 = or i32 %103, 48, !dbg !272
  %107 = select i1 %104, i32 %105, i32 %106, !dbg !276
  %108 = trunc i32 %107 to i8
  %109 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 4
  store i8 %108, i8* %109, align 1, !tbaa !222
  call void @llvm.dbg.value(metadata i32 5, metadata !147, metadata !DIExpression()), !dbg !254
  %110 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 5, !dbg !279
  store i8 58, i8* %110, align 1, !dbg !282, !tbaa !222
  call void @llvm.dbg.value(metadata i32 5, metadata !147, metadata !DIExpression()), !dbg !254
  call void @llvm.dbg.value(metadata i32 6, metadata !147, metadata !DIExpression()), !dbg !254
  call void @llvm.dbg.value(metadata i64 2, metadata !148, metadata !DIExpression()), !dbg !255
  call void @llvm.dbg.value(metadata i32 6, metadata !147, metadata !DIExpression()), !dbg !254
  %111 = getelementptr inbounds i8, i8* %69, i64 2, !dbg !256
  %112 = load i8, i8* %111, align 1, !dbg !256, !tbaa !222
  %113 = zext i8 %112 to i32, !dbg !256
  %114 = lshr i32 %113, 4, !dbg !260
  %115 = icmp ugt i8 %112, -97, !dbg !261
  %116 = add nuw nsw i32 %114, 55, !dbg !264
  %117 = or i32 %114, 48, !dbg !262
  %118 = select i1 %115, i32 %116, i32 %117, !dbg !266
  %119 = trunc i32 %118 to i8
  %120 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 6
  store i8 %119, i8* %120, align 1, !tbaa !222
  call void @llvm.dbg.value(metadata i32 7, metadata !147, metadata !DIExpression()), !dbg !254
  %121 = load i8, i8* %111, align 1, !dbg !268, !tbaa !222
  %122 = and i8 %121, 15, !dbg !270
  %123 = zext i8 %122 to i32, !dbg !270
  %124 = icmp ugt i8 %122, 9, !dbg !271
  %125 = add nuw nsw i32 %123, 55, !dbg !274
  %126 = or i32 %123, 48, !dbg !272
  %127 = select i1 %124, i32 %125, i32 %126, !dbg !276
  %128 = trunc i32 %127 to i8
  %129 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 7
  store i8 %128, i8* %129, align 1, !tbaa !222
  call void @llvm.dbg.value(metadata i32 8, metadata !147, metadata !DIExpression()), !dbg !254
  %130 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 8, !dbg !279
  store i8 58, i8* %130, align 1, !dbg !282, !tbaa !222
  call void @llvm.dbg.value(metadata i32 8, metadata !147, metadata !DIExpression()), !dbg !254
  call void @llvm.dbg.value(metadata i32 9, metadata !147, metadata !DIExpression()), !dbg !254
  call void @llvm.dbg.value(metadata i64 3, metadata !148, metadata !DIExpression()), !dbg !255
  call void @llvm.dbg.value(metadata i32 9, metadata !147, metadata !DIExpression()), !dbg !254
  %131 = getelementptr inbounds i8, i8* %69, i64 3, !dbg !256
  %132 = load i8, i8* %131, align 1, !dbg !256, !tbaa !222
  %133 = zext i8 %132 to i32, !dbg !256
  %134 = lshr i32 %133, 4, !dbg !260
  %135 = icmp ugt i8 %132, -97, !dbg !261
  %136 = add nuw nsw i32 %134, 55, !dbg !264
  %137 = or i32 %134, 48, !dbg !262
  %138 = select i1 %135, i32 %136, i32 %137, !dbg !266
  %139 = trunc i32 %138 to i8
  %140 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 9
  store i8 %139, i8* %140, align 1, !tbaa !222
  call void @llvm.dbg.value(metadata i32 10, metadata !147, metadata !DIExpression()), !dbg !254
  %141 = load i8, i8* %131, align 1, !dbg !268, !tbaa !222
  %142 = and i8 %141, 15, !dbg !270
  %143 = zext i8 %142 to i32, !dbg !270
  %144 = icmp ugt i8 %142, 9, !dbg !271
  %145 = add nuw nsw i32 %143, 55, !dbg !274
  %146 = or i32 %143, 48, !dbg !272
  %147 = select i1 %144, i32 %145, i32 %146, !dbg !276
  %148 = trunc i32 %147 to i8
  %149 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 10
  store i8 %148, i8* %149, align 1, !tbaa !222
  call void @llvm.dbg.value(metadata i32 11, metadata !147, metadata !DIExpression()), !dbg !254
  %150 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 11, !dbg !279
  store i8 58, i8* %150, align 1, !dbg !282, !tbaa !222
  call void @llvm.dbg.value(metadata i32 11, metadata !147, metadata !DIExpression()), !dbg !254
  call void @llvm.dbg.value(metadata i32 12, metadata !147, metadata !DIExpression()), !dbg !254
  call void @llvm.dbg.value(metadata i64 4, metadata !148, metadata !DIExpression()), !dbg !255
  call void @llvm.dbg.value(metadata i32 12, metadata !147, metadata !DIExpression()), !dbg !254
  %151 = getelementptr inbounds i8, i8* %69, i64 4, !dbg !256
  %152 = load i8, i8* %151, align 1, !dbg !256, !tbaa !222
  %153 = zext i8 %152 to i32, !dbg !256
  %154 = lshr i32 %153, 4, !dbg !260
  %155 = icmp ugt i8 %152, -97, !dbg !261
  %156 = add nuw nsw i32 %154, 55, !dbg !264
  %157 = or i32 %154, 48, !dbg !262
  %158 = select i1 %155, i32 %156, i32 %157, !dbg !266
  %159 = trunc i32 %158 to i8
  %160 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 12
  store i8 %159, i8* %160, align 1, !tbaa !222
  call void @llvm.dbg.value(metadata i32 13, metadata !147, metadata !DIExpression()), !dbg !254
  %161 = load i8, i8* %151, align 1, !dbg !268, !tbaa !222
  %162 = and i8 %161, 15, !dbg !270
  %163 = zext i8 %162 to i32, !dbg !270
  %164 = icmp ugt i8 %162, 9, !dbg !271
  %165 = add nuw nsw i32 %163, 55, !dbg !274
  %166 = or i32 %163, 48, !dbg !272
  %167 = select i1 %164, i32 %165, i32 %166, !dbg !276
  %168 = trunc i32 %167 to i8
  %169 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 13
  store i8 %168, i8* %169, align 1, !tbaa !222
  call void @llvm.dbg.value(metadata i32 14, metadata !147, metadata !DIExpression()), !dbg !254
  %170 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 14, !dbg !279
  store i8 58, i8* %170, align 1, !dbg !282, !tbaa !222
  call void @llvm.dbg.value(metadata i32 14, metadata !147, metadata !DIExpression()), !dbg !254
  call void @llvm.dbg.value(metadata i32 15, metadata !147, metadata !DIExpression()), !dbg !254
  call void @llvm.dbg.value(metadata i64 5, metadata !148, metadata !DIExpression()), !dbg !255
  call void @llvm.dbg.value(metadata i32 15, metadata !147, metadata !DIExpression()), !dbg !254
  %171 = getelementptr inbounds i8, i8* %69, i64 5, !dbg !256
  %172 = load i8, i8* %171, align 1, !dbg !256, !tbaa !222
  %173 = zext i8 %172 to i32, !dbg !256
  %174 = lshr i32 %173, 4, !dbg !260
  %175 = icmp ugt i8 %172, -97, !dbg !261
  %176 = add nuw nsw i32 %174, 55, !dbg !264
  %177 = or i32 %174, 48, !dbg !262
  %178 = select i1 %175, i32 %176, i32 %177, !dbg !266
  %179 = trunc i32 %178 to i8
  %180 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 15
  store i8 %179, i8* %180, align 1, !tbaa !222
  call void @llvm.dbg.value(metadata i32 16, metadata !147, metadata !DIExpression()), !dbg !254
  %181 = load i8, i8* %171, align 1, !dbg !268, !tbaa !222
  %182 = and i8 %181, 15, !dbg !270
  %183 = zext i8 %182 to i32, !dbg !270
  %184 = icmp ugt i8 %182, 9, !dbg !271
  %185 = or i32 %183, 48, !dbg !272
  %186 = add nuw nsw i32 %183, 55, !dbg !274
  %187 = select i1 %184, i32 %186, i32 %185, !dbg !276
  %188 = trunc i32 %187 to i8
  %189 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 16
  store i8 %188, i8* %189, align 1, !tbaa !222
  call void @llvm.dbg.value(metadata i32 16, metadata !147, metadata !DIExpression()), !dbg !254
  call void @llvm.dbg.value(metadata i32 17, metadata !147, metadata !DIExpression()), !dbg !254
  %190 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 17, !dbg !283
  store i8 0, i8* %190, align 1, !dbg !284, !tbaa !222
  %191 = getelementptr inbounds [20 x i8], [20 x i8]* %7, i64 0, i64 0, !dbg !285
  call void @llvm.lifetime.start.p0i8(i64 20, i8* nonnull %191) #3, !dbg !285
  call void @llvm.dbg.declare(metadata [20 x i8]* %7, metadata !150, metadata !DIExpression()), !dbg !285
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %191, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @xdp_pass_func.____fmt.1, i64 0, i64 0), i64 20, i32 1, i1 false), !dbg !285
  %192 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %191, i32 20, i8* nonnull %72) #3, !dbg !285
  call void @llvm.lifetime.end.p0i8(i64 20, i8* nonnull %191) #3, !dbg !286
  call void @llvm.lifetime.end.p0i8(i64 30, i8* nonnull %72) #3, !dbg !287
  br label %193, !dbg !288

; <label>:193:                                    ; preds = %62, %71
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %68) #3, !dbg !289
  br label %213, !dbg !290

; <label>:194:                                    ; preds = %41
  %195 = getelementptr inbounds [17 x i8], [17 x i8]* %8, i64 0, i64 0, !dbg !291
  call void @llvm.lifetime.start.p0i8(i64 17, i8* nonnull %195) #3, !dbg !291
  call void @llvm.dbg.declare(metadata [17 x i8]* %8, metadata !155, metadata !DIExpression()), !dbg !291
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %195, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @xdp_pass_func.____fmt.2, i64 0, i64 0), i64 17, i32 1, i1 false), !dbg !291
  %196 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %195, i32 17) #3, !dbg !291
  call void @llvm.lifetime.end.p0i8(i64 17, i8* nonnull %195) #3, !dbg !292
  %197 = bitcast i32* %9 to i8*, !dbg !293
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %197) #3, !dbg !293
  call void @llvm.dbg.value(metadata i32 680997, metadata !161, metadata !DIExpression()), !dbg !293
  store i32 680997, i32* %9, align 4, !dbg !293
  %198 = load i8, i8* %50, align 4, !dbg !293, !tbaa !222
  %199 = zext i8 %198 to i32, !dbg !293
  %200 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %197, i32 4, i32 %199) #3, !dbg !293
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %197) #3, !dbg !294
  %201 = bitcast i32* %10 to i8*, !dbg !295
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %201) #3, !dbg !295
  call void @llvm.dbg.value(metadata i32 680997, metadata !163, metadata !DIExpression()), !dbg !295
  store i32 680997, i32* %10, align 4, !dbg !295
  %202 = load i8, i8* %53, align 1, !dbg !295, !tbaa !222
  %203 = zext i8 %202 to i32, !dbg !295
  %204 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %201, i32 4, i32 %203) #3, !dbg !295
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %201) #3, !dbg !296
  %205 = bitcast i32* %11 to i8*, !dbg !297
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %205) #3, !dbg !297
  call void @llvm.dbg.value(metadata i32 680997, metadata !165, metadata !DIExpression()), !dbg !297
  store i32 680997, i32* %11, align 4, !dbg !297
  %206 = load i8, i8* %56, align 2, !dbg !297, !tbaa !222
  %207 = zext i8 %206 to i32, !dbg !297
  %208 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %205, i32 4, i32 %207) #3, !dbg !297
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %205) #3, !dbg !298
  %209 = bitcast i32* %12 to i8*, !dbg !299
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %209) #3, !dbg !299
  call void @llvm.dbg.value(metadata i32 680997, metadata !167, metadata !DIExpression()), !dbg !299
  store i32 680997, i32* %12, align 4, !dbg !299
  %210 = load i8, i8* %59, align 1, !dbg !299, !tbaa !222
  %211 = zext i8 %210 to i32, !dbg !299
  %212 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %209, i32 4, i32 %211) #3, !dbg !299
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %209) #3, !dbg !300
  br label %213

; <label>:213:                                    ; preds = %194, %193
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %45) #3, !dbg !301
  br label %214

; <label>:214:                                    ; preds = %213, %36, %32
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %25) #3, !dbg !301
  br label %215

; <label>:215:                                    ; preds = %1, %214
  ret i32 2, !dbg !301
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
!llvm.module.flags = !{!58, !59, !60}
!llvm.ident = !{!61}

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
!21 = !{!0, !22, !35, !37, !39, !45, !50}
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
!36 = distinct !DIGlobalVariable(name: "sw_nics", scope: !2, file: !3, line: 38, type: !24, isLocal: false, isDefinition: true)
!37 = !DIGlobalVariableExpression(var: !38, expr: !DIExpression())
!38 = distinct !DIGlobalVariable(name: "routes", scope: !2, file: !3, line: 51, type: !24, isLocal: false, isDefinition: true)
!39 = !DIGlobalVariableExpression(var: !40, expr: !DIExpression())
!40 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 169, type: !41, isLocal: false, isDefinition: true)
!41 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 32, elements: !43)
!42 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!43 = !{!44}
!44 = !DISubrange(count: 4)
!45 = !DIGlobalVariableExpression(var: !46, expr: !DIExpression())
!46 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !25, line: 20, type: !47, isLocal: true, isDefinition: true)
!47 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!48 = !DISubroutineType(types: !49)
!49 = !{!14, !14, !14}
!50 = !DIGlobalVariableExpression(var: !51, expr: !DIExpression())
!51 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !25, line: 38, type: !52, isLocal: true, isDefinition: true)
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DISubroutineType(types: !54)
!54 = !{!55, !56, !55, null}
!55 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!56 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !57, size: 64)
!57 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !42)
!58 = !{i32 2, !"Dwarf Version", i32 4}
!59 = !{i32 2, !"Debug Info Version", i32 3}
!60 = !{i32 1, !"wchar_size", i32 4}
!61 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
!62 = distinct !DISubprogram(name: "xdp_pass_func", scope: !3, file: !3, line: 61, type: !63, isLocal: false, isDefinition: true, scopeLine: 62, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !74)
!63 = !DISubroutineType(types: !64)
!64 = !{!55, !65}
!65 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !66, size: 64)
!66 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !67)
!67 = !{!68, !70, !71, !72, !73}
!68 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !66, file: !6, line: 2857, baseType: !69, size: 32)
!69 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !19, line: 27, baseType: !28)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !66, file: !6, line: 2858, baseType: !69, size: 32, offset: 32)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !66, file: !6, line: 2859, baseType: !69, size: 32, offset: 64)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !66, file: !6, line: 2861, baseType: !69, size: 32, offset: 96)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !66, file: !6, line: 2862, baseType: !69, size: 32, offset: 128)
!74 = !{!75, !76, !77, !78, !90, !91, !93, !112, !113, !124, !131, !138, !139, !141, !147, !148, !150, !155, !161, !163, !165, !167}
!75 = !DILocalVariable(name: "ctx", arg: 1, scope: !62, file: !3, line: 61, type: !65)
!76 = !DILocalVariable(name: "data", scope: !62, file: !3, line: 63, type: !14)
!77 = !DILocalVariable(name: "data_end", scope: !62, file: !3, line: 64, type: !14)
!78 = !DILocalVariable(name: "eth", scope: !62, file: !3, line: 65, type: !79)
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 64)
!80 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !81, line: 159, size: 112, elements: !82)
!81 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "/home/anuraag/IITB/Sem6/router-src/_switch/scripts/bpfcode")
!82 = !{!83, !88, !89}
!83 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !80, file: !81, line: 160, baseType: !84, size: 48)
!84 = !DICompositeType(tag: DW_TAG_array_type, baseType: !85, size: 48, elements: !86)
!85 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!86 = !{!87}
!87 = !DISubrange(count: 6)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !80, file: !81, line: 161, baseType: !84, size: 48, offset: 48)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !80, file: !81, line: 162, baseType: !16, size: 16, offset: 96)
!90 = !DILocalVariable(name: "int_key", scope: !62, file: !3, line: 72, type: !55)
!91 = !DILocalVariable(name: "int_val", scope: !62, file: !3, line: 73, type: !92)
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!93 = !DILocalVariable(name: "ip", scope: !62, file: !3, line: 83, type: !94)
!94 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !95, size: 64)
!95 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !96, line: 86, size: 160, elements: !97)
!96 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "/home/anuraag/IITB/Sem6/router-src/_switch/scripts/bpfcode")
!97 = !{!98, !100, !101, !102, !103, !104, !105, !106, !107, !109, !111}
!98 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !95, file: !96, line: 88, baseType: !99, size: 4, flags: DIFlagBitField, extraData: i64 0)
!99 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !19, line: 21, baseType: !85)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !95, file: !96, line: 89, baseType: !99, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !95, file: !96, line: 96, baseType: !99, size: 8, offset: 8)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !95, file: !96, line: 97, baseType: !16, size: 16, offset: 16)
!103 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !95, file: !96, line: 98, baseType: !16, size: 16, offset: 32)
!104 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !95, file: !96, line: 99, baseType: !16, size: 16, offset: 48)
!105 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !95, file: !96, line: 100, baseType: !99, size: 8, offset: 64)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !95, file: !96, line: 101, baseType: !99, size: 8, offset: 72)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !95, file: !96, line: 102, baseType: !108, size: 16, offset: 80)
!108 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !17, line: 31, baseType: !18)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !95, file: !96, line: 103, baseType: !110, size: 32, offset: 96)
!110 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !17, line: 27, baseType: !69)
!111 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !95, file: !96, line: 104, baseType: !110, size: 32, offset: 128)
!112 = !DILocalVariable(name: "dst_ip", scope: !62, file: !3, line: 88, type: !69)
!113 = !DILocalVariable(name: "key4", scope: !62, file: !3, line: 93, type: !114)
!114 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !62, file: !3, line: 90, size: 64, elements: !115)
!115 = !{!116, !120}
!116 = !DIDerivedType(tag: DW_TAG_member, name: "b32", scope: !114, file: !3, line: 91, baseType: !117, size: 64)
!117 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 64, elements: !118)
!118 = !{!119}
!119 = !DISubrange(count: 2)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "b8", scope: !114, file: !3, line: 92, baseType: !121, size: 64)
!121 = !DICompositeType(tag: DW_TAG_array_type, baseType: !99, size: 64, elements: !122)
!122 = !{!123}
!123 = !DISubrange(count: 8)
!124 = !DILocalVariable(name: "val", scope: !62, file: !3, line: 94, type: !125)
!125 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !126, size: 64)
!126 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "lpm_val", file: !3, line: 45, size: 56, elements: !127)
!127 = !{!128, !130}
!128 = !DIDerivedType(tag: DW_TAG_member, name: "dst_mac", scope: !126, file: !3, line: 46, baseType: !129, size: 48)
!129 = !DICompositeType(tag: DW_TAG_array_type, baseType: !99, size: 48, elements: !86)
!130 = !DIDerivedType(tag: DW_TAG_member, name: "out_of_port", scope: !126, file: !3, line: 47, baseType: !99, size: 8, offset: 48)
!131 = !DILocalVariable(name: "____fmt", scope: !132, file: !3, line: 105, type: !135)
!132 = distinct !DILexicalBlock(scope: !133, file: !3, line: 105, column: 3)
!133 = distinct !DILexicalBlock(scope: !134, file: !3, line: 104, column: 12)
!134 = distinct !DILexicalBlock(scope: !62, file: !3, line: 104, column: 8)
!135 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 176, elements: !136)
!136 = !{!137}
!137 = !DISubrange(count: 22)
!138 = !DILocalVariable(name: "ifaceno", scope: !133, file: !3, line: 106, type: !55)
!139 = !DILocalVariable(name: "srcmac_addr", scope: !133, file: !3, line: 107, type: !140)
!140 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !99, size: 64)
!141 = !DILocalVariable(name: "buffer", scope: !142, file: !3, line: 110, type: !144)
!142 = distinct !DILexicalBlock(scope: !143, file: !3, line: 109, column: 18)
!143 = distinct !DILexicalBlock(scope: !133, file: !3, line: 109, column: 6)
!144 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 240, elements: !145)
!145 = !{!146}
!146 = !DISubrange(count: 30)
!147 = !DILocalVariable(name: "run", scope: !142, file: !3, line: 111, type: !55)
!148 = !DILocalVariable(name: "p", scope: !149, file: !3, line: 118, type: !55)
!149 = distinct !DILexicalBlock(scope: !142, file: !3, line: 118, column: 4)
!150 = !DILocalVariable(name: "____fmt", scope: !151, file: !3, line: 137, type: !152)
!151 = distinct !DILexicalBlock(scope: !142, file: !3, line: 137, column: 4)
!152 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 160, elements: !153)
!153 = !{!154}
!154 = !DISubrange(count: 20)
!155 = !DILocalVariable(name: "____fmt", scope: !156, file: !3, line: 140, type: !158)
!156 = distinct !DILexicalBlock(scope: !157, file: !3, line: 140, column: 3)
!157 = distinct !DILexicalBlock(scope: !134, file: !3, line: 139, column: 7)
!158 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 136, elements: !159)
!159 = !{!160}
!160 = !DISubrange(count: 17)
!161 = !DILocalVariable(name: "____fmt", scope: !162, file: !3, line: 141, type: !41)
!162 = distinct !DILexicalBlock(scope: !157, file: !3, line: 141, column: 3)
!163 = !DILocalVariable(name: "____fmt", scope: !164, file: !3, line: 142, type: !41)
!164 = distinct !DILexicalBlock(scope: !157, file: !3, line: 142, column: 6)
!165 = !DILocalVariable(name: "____fmt", scope: !166, file: !3, line: 143, type: !41)
!166 = distinct !DILexicalBlock(scope: !157, file: !3, line: 143, column: 6)
!167 = !DILocalVariable(name: "____fmt", scope: !168, file: !3, line: 144, type: !41)
!168 = distinct !DILexicalBlock(scope: !157, file: !3, line: 144, column: 6)
!169 = !DILocation(line: 61, column: 35, scope: !62)
!170 = !DILocation(line: 63, column: 34, scope: !62)
!171 = !{!172, !173, i64 0}
!172 = !{!"xdp_md", !173, i64 0, !173, i64 4, !173, i64 8, !173, i64 12, !173, i64 16}
!173 = !{!"int", !174, i64 0}
!174 = !{!"omnipotent char", !175, i64 0}
!175 = !{!"Simple C/C++ TBAA"}
!176 = !DILocation(line: 63, column: 23, scope: !62)
!177 = !DILocation(line: 63, column: 15, scope: !62)
!178 = !DILocation(line: 63, column: 8, scope: !62)
!179 = !DILocation(line: 64, column: 38, scope: !62)
!180 = !{!172, !173, i64 4}
!181 = !DILocation(line: 64, column: 27, scope: !62)
!182 = !DILocation(line: 64, column: 19, scope: !62)
!183 = !DILocation(line: 64, column: 8, scope: !62)
!184 = !DILocation(line: 65, column: 23, scope: !62)
!185 = !DILocation(line: 65, column: 17, scope: !62)
!186 = !DILocation(line: 68, column: 11, scope: !187)
!187 = distinct !DILexicalBlock(scope: !62, file: !3, line: 68, column: 6)
!188 = !DILocation(line: 68, column: 35, scope: !187)
!189 = !DILocation(line: 68, column: 6, scope: !62)
!190 = !DILocation(line: 72, column: 5, scope: !62)
!191 = !DILocation(line: 72, column: 9, scope: !62)
!192 = !{!173, !173, i64 0}
!193 = !DILocation(line: 74, column: 15, scope: !62)
!194 = !DILocation(line: 73, column: 10, scope: !62)
!195 = !DILocation(line: 75, column: 8, scope: !196)
!196 = distinct !DILexicalBlock(scope: !62, file: !3, line: 75, column: 8)
!197 = !DILocation(line: 75, column: 8, scope: !62)
!198 = !DILocation(line: 76, column: 19, scope: !199)
!199 = distinct !DILexicalBlock(scope: !196, file: !3, line: 75, column: 16)
!200 = !DILocation(line: 77, column: 2, scope: !199)
!201 = !DILocation(line: 80, column: 11, scope: !202)
!202 = distinct !DILexicalBlock(scope: !62, file: !3, line: 80, column: 6)
!203 = !{!204, !205, i64 12}
!204 = !{!"ethhdr", !174, i64 0, !174, i64 6, !205, i64 12}
!205 = !{!"short", !174, i64 0}
!206 = !DILocation(line: 80, column: 19, scope: !202)
!207 = !DILocation(line: 80, column: 6, scope: !62)
!208 = !DILocation(line: 83, column: 21, scope: !62)
!209 = !DILocation(line: 85, column: 8, scope: !210)
!210 = distinct !DILexicalBlock(scope: !62, file: !3, line: 85, column: 5)
!211 = !DILocation(line: 85, column: 33, scope: !210)
!212 = !DILocation(line: 85, column: 31, scope: !210)
!213 = !DILocation(line: 85, column: 5, scope: !62)
!214 = !DILocation(line: 88, column: 21, scope: !62)
!215 = !{!216, !173, i64 16}
!216 = !{!"iphdr", !174, i64 0, !174, i64 0, !174, i64 1, !205, i64 2, !205, i64 4, !205, i64 6, !174, i64 8, !174, i64 9, !205, i64 10, !173, i64 12, !173, i64 16}
!217 = !DILocation(line: 88, column: 8, scope: !62)
!218 = !DILocation(line: 90, column: 2, scope: !62)
!219 = !DILocation(line: 94, column: 21, scope: !62)
!220 = !DILocation(line: 96, column: 2, scope: !62)
!221 = !DILocation(line: 96, column: 14, scope: !62)
!222 = !{!174, !174, i64 0}
!223 = !DILocation(line: 97, column: 15, scope: !62)
!224 = !DILocation(line: 97, column: 7, scope: !62)
!225 = !DILocation(line: 97, column: 2, scope: !62)
!226 = !DILocation(line: 97, column: 13, scope: !62)
!227 = !DILocation(line: 98, column: 23, scope: !62)
!228 = !DILocation(line: 98, column: 15, scope: !62)
!229 = !DILocation(line: 98, column: 2, scope: !62)
!230 = !DILocation(line: 98, column: 13, scope: !62)
!231 = !DILocation(line: 99, column: 23, scope: !62)
!232 = !DILocation(line: 99, column: 15, scope: !62)
!233 = !DILocation(line: 99, column: 2, scope: !62)
!234 = !DILocation(line: 99, column: 13, scope: !62)
!235 = !DILocation(line: 100, column: 23, scope: !62)
!236 = !DILocation(line: 100, column: 15, scope: !62)
!237 = !DILocation(line: 100, column: 2, scope: !62)
!238 = !DILocation(line: 100, column: 13, scope: !62)
!239 = !DILocation(line: 103, column: 11, scope: !62)
!240 = !DILocation(line: 104, column: 8, scope: !134)
!241 = !DILocation(line: 104, column: 8, scope: !62)
!242 = !DILocation(line: 105, column: 3, scope: !132)
!243 = !{!244, !174, i64 6}
!244 = !{!"lpm_val", !174, i64 0, !174, i64 6}
!245 = !DILocation(line: 105, column: 3, scope: !133)
!246 = !DILocation(line: 106, column: 3, scope: !133)
!247 = !DILocation(line: 106, column: 7, scope: !133)
!248 = !DILocation(line: 108, column: 17, scope: !133)
!249 = !DILocation(line: 107, column: 9, scope: !133)
!250 = !DILocation(line: 109, column: 6, scope: !143)
!251 = !DILocation(line: 109, column: 6, scope: !133)
!252 = !DILocation(line: 110, column: 4, scope: !142)
!253 = !DILocation(line: 110, column: 9, scope: !142)
!254 = !DILocation(line: 111, column: 8, scope: !142)
!255 = !DILocation(line: 118, column: 12, scope: !149)
!256 = !DILocation(line: 119, column: 10, scope: !257)
!257 = distinct !DILexicalBlock(scope: !258, file: !3, line: 119, column: 9)
!258 = distinct !DILexicalBlock(scope: !259, file: !3, line: 118, column: 30)
!259 = distinct !DILexicalBlock(scope: !149, file: !3, line: 118, column: 4)
!260 = !DILocation(line: 119, column: 24, scope: !257)
!261 = !DILocation(line: 119, column: 29, scope: !257)
!262 = !DILocation(line: 122, column: 40, scope: !263)
!263 = distinct !DILexicalBlock(scope: !257, file: !3, line: 121, column: 10)
!264 = !DILocation(line: 120, column: 45, scope: !265)
!265 = distinct !DILexicalBlock(scope: !257, file: !3, line: 119, column: 35)
!266 = !DILocation(line: 119, column: 9, scope: !258)
!267 = !DILocation(line: 122, column: 18, scope: !263)
!268 = !DILocation(line: 125, column: 10, scope: !269)
!269 = distinct !DILexicalBlock(scope: !258, file: !3, line: 125, column: 9)
!270 = !DILocation(line: 125, column: 24, scope: !269)
!271 = !DILocation(line: 125, column: 31, scope: !269)
!272 = !DILocation(line: 128, column: 42, scope: !273)
!273 = distinct !DILexicalBlock(scope: !269, file: !3, line: 127, column: 10)
!274 = !DILocation(line: 126, column: 47, scope: !275)
!275 = distinct !DILexicalBlock(scope: !269, file: !3, line: 125, column: 37)
!276 = !DILocation(line: 125, column: 9, scope: !258)
!277 = !DILocation(line: 128, column: 6, scope: !273)
!278 = !DILocation(line: 128, column: 18, scope: !273)
!279 = !DILocation(line: 132, column: 6, scope: !280)
!280 = distinct !DILexicalBlock(scope: !281, file: !3, line: 130, column: 15)
!281 = distinct !DILexicalBlock(scope: !258, file: !3, line: 130, column: 8)
!282 = !DILocation(line: 132, column: 18, scope: !280)
!283 = !DILocation(line: 136, column: 4, scope: !142)
!284 = !DILocation(line: 136, column: 16, scope: !142)
!285 = !DILocation(line: 137, column: 4, scope: !151)
!286 = !DILocation(line: 137, column: 4, scope: !142)
!287 = !DILocation(line: 138, column: 3, scope: !143)
!288 = !DILocation(line: 138, column: 3, scope: !142)
!289 = !DILocation(line: 139, column: 2, scope: !134)
!290 = !DILocation(line: 139, column: 2, scope: !133)
!291 = !DILocation(line: 140, column: 3, scope: !156)
!292 = !DILocation(line: 140, column: 3, scope: !157)
!293 = !DILocation(line: 141, column: 3, scope: !162)
!294 = !DILocation(line: 141, column: 3, scope: !157)
!295 = !DILocation(line: 142, column: 6, scope: !164)
!296 = !DILocation(line: 142, column: 6, scope: !157)
!297 = !DILocation(line: 143, column: 6, scope: !166)
!298 = !DILocation(line: 143, column: 6, scope: !157)
!299 = !DILocation(line: 144, column: 6, scope: !168)
!300 = !DILocation(line: 144, column: 6, scope: !157)
!301 = !DILocation(line: 167, column: 1, scope: !62)
