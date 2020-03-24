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
@sw_nics = global %struct.bpf_map_def { i32 2, i32 4, i32 6, i32 10, i32 0, i32 0, i32 0 }, section "maps", align 4, !dbg !35
@routes = global %struct.bpf_map_def { i32 11, i32 8, i32 1, i32 512, i32 1, i32 0, i32 0 }, section "maps", align 4, !dbg !37
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
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !75, metadata !DIExpression()), !dbg !167
  %13 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !168
  %14 = load i32, i32* %13, align 4, !dbg !168, !tbaa !169
  %15 = zext i32 %14 to i64, !dbg !174
  %16 = inttoptr i64 %15 to i8*, !dbg !175
  call void @llvm.dbg.value(metadata i8* %16, metadata !76, metadata !DIExpression()), !dbg !176
  %17 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !177
  %18 = load i32, i32* %17, align 4, !dbg !177, !tbaa !178
  %19 = zext i32 %18 to i64, !dbg !179
  %20 = inttoptr i64 %19 to i8*, !dbg !180
  call void @llvm.dbg.value(metadata i8* %20, metadata !77, metadata !DIExpression()), !dbg !181
  %21 = inttoptr i64 %15 to %struct.ethhdr*, !dbg !182
  call void @llvm.dbg.value(metadata %struct.ethhdr* %21, metadata !78, metadata !DIExpression()), !dbg !183
  %22 = getelementptr i8, i8* %16, i64 14, !dbg !184
  %23 = icmp ugt i8* %22, %20, !dbg !186
  br i1 %23, label %214, label %24, !dbg !187

; <label>:24:                                     ; preds = %1
  %25 = bitcast i32* %2 to i8*, !dbg !188
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %25) #3, !dbg !188
  call void @llvm.dbg.value(metadata i32 0, metadata !90, metadata !DIExpression()), !dbg !189
  store i32 0, i32* %2, align 4, !dbg !189, !tbaa !190
  %26 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @counter to i8*), i8* nonnull %25) #3, !dbg !191
  %27 = bitcast i8* %26 to i32*, !dbg !191
  call void @llvm.dbg.value(metadata i32* %27, metadata !91, metadata !DIExpression()), !dbg !192
  %28 = icmp eq i8* %26, null, !dbg !193
  br i1 %28, label %32, label %29, !dbg !195

; <label>:29:                                     ; preds = %24
  %30 = load i32, i32* %27, align 4, !dbg !196, !tbaa !190
  %31 = add nsw i32 %30, 1, !dbg !196
  store i32 %31, i32* %27, align 4, !dbg !196, !tbaa !190
  br label %32, !dbg !198

; <label>:32:                                     ; preds = %24, %29
  %33 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %21, i64 0, i32 2, !dbg !199
  %34 = load i16, i16* %33, align 1, !dbg !199, !tbaa !201
  %35 = icmp eq i16 %34, 8, !dbg !204
  br i1 %35, label %36, label %213, !dbg !205

; <label>:36:                                     ; preds = %32
  call void @llvm.dbg.value(metadata i8* %22, metadata !93, metadata !DIExpression()), !dbg !206
  %37 = getelementptr inbounds i8, i8* %16, i64 414, !dbg !207
  %38 = bitcast i8* %37 to %struct.iphdr*, !dbg !207
  %39 = inttoptr i64 %19 to %struct.iphdr*, !dbg !209
  %40 = icmp ugt %struct.iphdr* %38, %39, !dbg !210
  br i1 %40, label %213, label %41, !dbg !211

; <label>:41:                                     ; preds = %36
  %42 = getelementptr inbounds i8, i8* %16, i64 30, !dbg !212
  %43 = bitcast i8* %42 to i32*, !dbg !212
  %44 = load i32, i32* %43, align 4, !dbg !212, !tbaa !213
  call void @llvm.dbg.value(metadata i32 %44, metadata !112, metadata !DIExpression()), !dbg !215
  %45 = bitcast %union.anon* %3 to i8*, !dbg !216
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %45) #3, !dbg !216
  call void @llvm.dbg.value(metadata %struct.lpm_val* null, metadata !124, metadata !DIExpression()), !dbg !217
  %46 = getelementptr inbounds %union.anon, %union.anon* %3, i64 0, i32 0, i64 0, !dbg !218
  store i32 32, i32* %46, align 4, !dbg !219, !tbaa !220
  %47 = trunc i32 %44 to i8, !dbg !221
  %48 = bitcast %union.anon* %3 to [8 x i8]*, !dbg !222
  %49 = getelementptr inbounds %union.anon, %union.anon* %3, i64 0, i32 0, i64 1, !dbg !223
  %50 = bitcast i32* %49 to i8*, !dbg !223
  store i8 %47, i8* %50, align 4, !dbg !224, !tbaa !220
  %51 = lshr i32 %44, 8, !dbg !225
  %52 = trunc i32 %51 to i8, !dbg !226
  %53 = getelementptr inbounds [8 x i8], [8 x i8]* %48, i64 0, i64 5, !dbg !227
  store i8 %52, i8* %53, align 1, !dbg !228, !tbaa !220
  %54 = lshr i32 %44, 16, !dbg !229
  %55 = trunc i32 %54 to i8, !dbg !230
  %56 = getelementptr inbounds [8 x i8], [8 x i8]* %48, i64 0, i64 6, !dbg !231
  store i8 %55, i8* %56, align 2, !dbg !232, !tbaa !220
  %57 = lshr i32 %44, 24, !dbg !233
  %58 = trunc i32 %57 to i8, !dbg !234
  %59 = getelementptr inbounds [8 x i8], [8 x i8]* %48, i64 0, i64 7, !dbg !235
  store i8 %58, i8* %59, align 1, !dbg !236, !tbaa !220
  %60 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @routes to i8*), i8* nonnull %45) #3, !dbg !237
  call void @llvm.dbg.value(metadata i8* %60, metadata !124, metadata !DIExpression()), !dbg !217
  %61 = icmp eq i8* %60, null, !dbg !238
  br i1 %61, label %193, label %62, !dbg !239

; <label>:62:                                     ; preds = %41
  %63 = getelementptr inbounds [22 x i8], [22 x i8]* %4, i64 0, i64 0, !dbg !240
  call void @llvm.lifetime.start.p0i8(i64 22, i8* nonnull %63) #3, !dbg !240
  call void @llvm.dbg.declare(metadata [22 x i8]* %4, metadata !129, metadata !DIExpression()), !dbg !240
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %63, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @xdp_pass_func.____fmt, i64 0, i64 0), i64 22, i32 1, i1 false), !dbg !240
  %64 = load i8, i8* %60, align 1, !dbg !240, !tbaa !241
  %65 = zext i8 %64 to i32, !dbg !240
  %66 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %63, i32 22, i32 %65) #3, !dbg !240
  call void @llvm.lifetime.end.p0i8(i64 22, i8* nonnull %63) #3, !dbg !243
  %67 = bitcast i32* %5 to i8*, !dbg !244
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %67) #3, !dbg !244
  call void @llvm.dbg.value(metadata i32 3, metadata !136, metadata !DIExpression()), !dbg !245
  store i32 3, i32* %5, align 4, !dbg !245, !tbaa !190
  %68 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @sw_nics to i8*), i8* nonnull %67) #3, !dbg !246
  call void @llvm.dbg.value(metadata i8* %68, metadata !137, metadata !DIExpression()), !dbg !247
  %69 = icmp eq i8* %68, null, !dbg !248
  br i1 %69, label %192, label %70, !dbg !249

; <label>:70:                                     ; preds = %62
  %71 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 0, !dbg !250
  call void @llvm.lifetime.start.p0i8(i64 30, i8* nonnull %71) #3, !dbg !250
  call void @llvm.dbg.declare(metadata [30 x i8]* %6, metadata !139, metadata !DIExpression()), !dbg !251
  call void @llvm.dbg.value(metadata i32 0, metadata !145, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i32 0, metadata !146, metadata !DIExpression()), !dbg !253
  call void @llvm.dbg.value(metadata i64 0, metadata !146, metadata !DIExpression()), !dbg !253
  call void @llvm.dbg.value(metadata i32 0, metadata !145, metadata !DIExpression()), !dbg !252
  %72 = load i8, i8* %68, align 1, !dbg !254, !tbaa !220
  %73 = zext i8 %72 to i32, !dbg !254
  %74 = lshr i32 %73, 4, !dbg !258
  %75 = icmp ugt i8 %72, -97, !dbg !259
  %76 = or i32 %74, 48, !dbg !260
  %77 = add nuw nsw i32 %74, 55, !dbg !262
  %78 = select i1 %75, i32 %77, i32 %76, !dbg !264
  %79 = trunc i32 %78 to i8
  store i8 %79, i8* %71, align 1, !dbg !265
  call void @llvm.dbg.value(metadata i32 1, metadata !145, metadata !DIExpression()), !dbg !252
  %80 = load i8, i8* %68, align 1, !dbg !266, !tbaa !220
  %81 = and i8 %80, 15, !dbg !268
  %82 = zext i8 %81 to i32, !dbg !268
  %83 = icmp ugt i8 %81, 9, !dbg !269
  %84 = or i32 %82, 48, !dbg !270
  %85 = add nuw nsw i32 %82, 55, !dbg !272
  %86 = select i1 %83, i32 %85, i32 %84, !dbg !274
  %87 = trunc i32 %86 to i8
  %88 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 1, !dbg !275
  store i8 %87, i8* %88, align 1, !dbg !276
  call void @llvm.dbg.value(metadata i32 2, metadata !145, metadata !DIExpression()), !dbg !252
  %89 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 2, !dbg !277
  store i8 58, i8* %89, align 1, !dbg !280, !tbaa !220
  call void @llvm.dbg.value(metadata i32 2, metadata !145, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i32 3, metadata !145, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i64 1, metadata !146, metadata !DIExpression()), !dbg !253
  call void @llvm.dbg.value(metadata i32 3, metadata !145, metadata !DIExpression()), !dbg !252
  %90 = getelementptr inbounds i8, i8* %68, i64 1, !dbg !254
  %91 = load i8, i8* %90, align 1, !dbg !254, !tbaa !220
  %92 = zext i8 %91 to i32, !dbg !254
  %93 = lshr i32 %92, 4, !dbg !258
  %94 = icmp ugt i8 %91, -97, !dbg !259
  %95 = add nuw nsw i32 %93, 55, !dbg !262
  %96 = or i32 %93, 48, !dbg !260
  %97 = select i1 %94, i32 %95, i32 %96, !dbg !264
  %98 = trunc i32 %97 to i8
  %99 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 3
  store i8 %98, i8* %99, align 1, !tbaa !220
  call void @llvm.dbg.value(metadata i32 4, metadata !145, metadata !DIExpression()), !dbg !252
  %100 = load i8, i8* %90, align 1, !dbg !266, !tbaa !220
  %101 = and i8 %100, 15, !dbg !268
  %102 = zext i8 %101 to i32, !dbg !268
  %103 = icmp ugt i8 %101, 9, !dbg !269
  %104 = add nuw nsw i32 %102, 55, !dbg !272
  %105 = or i32 %102, 48, !dbg !270
  %106 = select i1 %103, i32 %104, i32 %105, !dbg !274
  %107 = trunc i32 %106 to i8
  %108 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 4
  store i8 %107, i8* %108, align 1, !tbaa !220
  call void @llvm.dbg.value(metadata i32 5, metadata !145, metadata !DIExpression()), !dbg !252
  %109 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 5, !dbg !277
  store i8 58, i8* %109, align 1, !dbg !280, !tbaa !220
  call void @llvm.dbg.value(metadata i32 5, metadata !145, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i32 6, metadata !145, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i64 2, metadata !146, metadata !DIExpression()), !dbg !253
  call void @llvm.dbg.value(metadata i32 6, metadata !145, metadata !DIExpression()), !dbg !252
  %110 = getelementptr inbounds i8, i8* %68, i64 2, !dbg !254
  %111 = load i8, i8* %110, align 1, !dbg !254, !tbaa !220
  %112 = zext i8 %111 to i32, !dbg !254
  %113 = lshr i32 %112, 4, !dbg !258
  %114 = icmp ugt i8 %111, -97, !dbg !259
  %115 = add nuw nsw i32 %113, 55, !dbg !262
  %116 = or i32 %113, 48, !dbg !260
  %117 = select i1 %114, i32 %115, i32 %116, !dbg !264
  %118 = trunc i32 %117 to i8
  %119 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 6
  store i8 %118, i8* %119, align 1, !tbaa !220
  call void @llvm.dbg.value(metadata i32 7, metadata !145, metadata !DIExpression()), !dbg !252
  %120 = load i8, i8* %110, align 1, !dbg !266, !tbaa !220
  %121 = and i8 %120, 15, !dbg !268
  %122 = zext i8 %121 to i32, !dbg !268
  %123 = icmp ugt i8 %121, 9, !dbg !269
  %124 = add nuw nsw i32 %122, 55, !dbg !272
  %125 = or i32 %122, 48, !dbg !270
  %126 = select i1 %123, i32 %124, i32 %125, !dbg !274
  %127 = trunc i32 %126 to i8
  %128 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 7
  store i8 %127, i8* %128, align 1, !tbaa !220
  call void @llvm.dbg.value(metadata i32 8, metadata !145, metadata !DIExpression()), !dbg !252
  %129 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 8, !dbg !277
  store i8 58, i8* %129, align 1, !dbg !280, !tbaa !220
  call void @llvm.dbg.value(metadata i32 8, metadata !145, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i32 9, metadata !145, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i64 3, metadata !146, metadata !DIExpression()), !dbg !253
  call void @llvm.dbg.value(metadata i32 9, metadata !145, metadata !DIExpression()), !dbg !252
  %130 = getelementptr inbounds i8, i8* %68, i64 3, !dbg !254
  %131 = load i8, i8* %130, align 1, !dbg !254, !tbaa !220
  %132 = zext i8 %131 to i32, !dbg !254
  %133 = lshr i32 %132, 4, !dbg !258
  %134 = icmp ugt i8 %131, -97, !dbg !259
  %135 = add nuw nsw i32 %133, 55, !dbg !262
  %136 = or i32 %133, 48, !dbg !260
  %137 = select i1 %134, i32 %135, i32 %136, !dbg !264
  %138 = trunc i32 %137 to i8
  %139 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 9
  store i8 %138, i8* %139, align 1, !tbaa !220
  call void @llvm.dbg.value(metadata i32 10, metadata !145, metadata !DIExpression()), !dbg !252
  %140 = load i8, i8* %130, align 1, !dbg !266, !tbaa !220
  %141 = and i8 %140, 15, !dbg !268
  %142 = zext i8 %141 to i32, !dbg !268
  %143 = icmp ugt i8 %141, 9, !dbg !269
  %144 = add nuw nsw i32 %142, 55, !dbg !272
  %145 = or i32 %142, 48, !dbg !270
  %146 = select i1 %143, i32 %144, i32 %145, !dbg !274
  %147 = trunc i32 %146 to i8
  %148 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 10
  store i8 %147, i8* %148, align 1, !tbaa !220
  call void @llvm.dbg.value(metadata i32 11, metadata !145, metadata !DIExpression()), !dbg !252
  %149 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 11, !dbg !277
  store i8 58, i8* %149, align 1, !dbg !280, !tbaa !220
  call void @llvm.dbg.value(metadata i32 11, metadata !145, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i32 12, metadata !145, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i64 4, metadata !146, metadata !DIExpression()), !dbg !253
  call void @llvm.dbg.value(metadata i32 12, metadata !145, metadata !DIExpression()), !dbg !252
  %150 = getelementptr inbounds i8, i8* %68, i64 4, !dbg !254
  %151 = load i8, i8* %150, align 1, !dbg !254, !tbaa !220
  %152 = zext i8 %151 to i32, !dbg !254
  %153 = lshr i32 %152, 4, !dbg !258
  %154 = icmp ugt i8 %151, -97, !dbg !259
  %155 = add nuw nsw i32 %153, 55, !dbg !262
  %156 = or i32 %153, 48, !dbg !260
  %157 = select i1 %154, i32 %155, i32 %156, !dbg !264
  %158 = trunc i32 %157 to i8
  %159 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 12
  store i8 %158, i8* %159, align 1, !tbaa !220
  call void @llvm.dbg.value(metadata i32 13, metadata !145, metadata !DIExpression()), !dbg !252
  %160 = load i8, i8* %150, align 1, !dbg !266, !tbaa !220
  %161 = and i8 %160, 15, !dbg !268
  %162 = zext i8 %161 to i32, !dbg !268
  %163 = icmp ugt i8 %161, 9, !dbg !269
  %164 = add nuw nsw i32 %162, 55, !dbg !272
  %165 = or i32 %162, 48, !dbg !270
  %166 = select i1 %163, i32 %164, i32 %165, !dbg !274
  %167 = trunc i32 %166 to i8
  %168 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 13
  store i8 %167, i8* %168, align 1, !tbaa !220
  call void @llvm.dbg.value(metadata i32 14, metadata !145, metadata !DIExpression()), !dbg !252
  %169 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 14, !dbg !277
  store i8 58, i8* %169, align 1, !dbg !280, !tbaa !220
  call void @llvm.dbg.value(metadata i32 14, metadata !145, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i32 15, metadata !145, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i64 5, metadata !146, metadata !DIExpression()), !dbg !253
  call void @llvm.dbg.value(metadata i32 15, metadata !145, metadata !DIExpression()), !dbg !252
  %170 = getelementptr inbounds i8, i8* %68, i64 5, !dbg !254
  %171 = load i8, i8* %170, align 1, !dbg !254, !tbaa !220
  %172 = zext i8 %171 to i32, !dbg !254
  %173 = lshr i32 %172, 4, !dbg !258
  %174 = icmp ugt i8 %171, -97, !dbg !259
  %175 = add nuw nsw i32 %173, 55, !dbg !262
  %176 = or i32 %173, 48, !dbg !260
  %177 = select i1 %174, i32 %175, i32 %176, !dbg !264
  %178 = trunc i32 %177 to i8
  %179 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 15
  store i8 %178, i8* %179, align 1, !tbaa !220
  call void @llvm.dbg.value(metadata i32 16, metadata !145, metadata !DIExpression()), !dbg !252
  %180 = load i8, i8* %170, align 1, !dbg !266, !tbaa !220
  %181 = and i8 %180, 15, !dbg !268
  %182 = zext i8 %181 to i32, !dbg !268
  %183 = icmp ugt i8 %181, 9, !dbg !269
  %184 = or i32 %182, 48, !dbg !270
  %185 = add nuw nsw i32 %182, 55, !dbg !272
  %186 = select i1 %183, i32 %185, i32 %184, !dbg !274
  %187 = trunc i32 %186 to i8
  %188 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 16
  store i8 %187, i8* %188, align 1, !tbaa !220
  call void @llvm.dbg.value(metadata i32 16, metadata !145, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i32 17, metadata !145, metadata !DIExpression()), !dbg !252
  %189 = getelementptr inbounds [30 x i8], [30 x i8]* %6, i64 0, i64 17, !dbg !281
  store i8 0, i8* %189, align 1, !dbg !282, !tbaa !220
  %190 = getelementptr inbounds [20 x i8], [20 x i8]* %7, i64 0, i64 0, !dbg !283
  call void @llvm.lifetime.start.p0i8(i64 20, i8* nonnull %190) #3, !dbg !283
  call void @llvm.dbg.declare(metadata [20 x i8]* %7, metadata !148, metadata !DIExpression()), !dbg !283
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %190, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @xdp_pass_func.____fmt.1, i64 0, i64 0), i64 20, i32 1, i1 false), !dbg !283
  %191 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %190, i32 20, i8* nonnull %71) #3, !dbg !283
  call void @llvm.lifetime.end.p0i8(i64 20, i8* nonnull %190) #3, !dbg !284
  call void @llvm.lifetime.end.p0i8(i64 30, i8* nonnull %71) #3, !dbg !285
  br label %192, !dbg !286

; <label>:192:                                    ; preds = %62, %70
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %67) #3, !dbg !287
  br label %212, !dbg !288

; <label>:193:                                    ; preds = %41
  %194 = getelementptr inbounds [17 x i8], [17 x i8]* %8, i64 0, i64 0, !dbg !289
  call void @llvm.lifetime.start.p0i8(i64 17, i8* nonnull %194) #3, !dbg !289
  call void @llvm.dbg.declare(metadata [17 x i8]* %8, metadata !153, metadata !DIExpression()), !dbg !289
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %194, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @xdp_pass_func.____fmt.2, i64 0, i64 0), i64 17, i32 1, i1 false), !dbg !289
  %195 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %194, i32 17) #3, !dbg !289
  call void @llvm.lifetime.end.p0i8(i64 17, i8* nonnull %194) #3, !dbg !290
  %196 = bitcast i32* %9 to i8*, !dbg !291
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %196) #3, !dbg !291
  call void @llvm.dbg.value(metadata i32 680997, metadata !159, metadata !DIExpression()), !dbg !291
  store i32 680997, i32* %9, align 4, !dbg !291
  %197 = load i8, i8* %50, align 4, !dbg !291, !tbaa !220
  %198 = zext i8 %197 to i32, !dbg !291
  %199 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %196, i32 4, i32 %198) #3, !dbg !291
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %196) #3, !dbg !292
  %200 = bitcast i32* %10 to i8*, !dbg !293
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %200) #3, !dbg !293
  call void @llvm.dbg.value(metadata i32 680997, metadata !161, metadata !DIExpression()), !dbg !293
  store i32 680997, i32* %10, align 4, !dbg !293
  %201 = load i8, i8* %53, align 1, !dbg !293, !tbaa !220
  %202 = zext i8 %201 to i32, !dbg !293
  %203 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %200, i32 4, i32 %202) #3, !dbg !293
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %200) #3, !dbg !294
  %204 = bitcast i32* %11 to i8*, !dbg !295
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %204) #3, !dbg !295
  call void @llvm.dbg.value(metadata i32 680997, metadata !163, metadata !DIExpression()), !dbg !295
  store i32 680997, i32* %11, align 4, !dbg !295
  %205 = load i8, i8* %56, align 2, !dbg !295, !tbaa !220
  %206 = zext i8 %205 to i32, !dbg !295
  %207 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %204, i32 4, i32 %206) #3, !dbg !295
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %204) #3, !dbg !296
  %208 = bitcast i32* %12 to i8*, !dbg !297
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %208) #3, !dbg !297
  call void @llvm.dbg.value(metadata i32 680997, metadata !165, metadata !DIExpression()), !dbg !297
  store i32 680997, i32* %12, align 4, !dbg !297
  %209 = load i8, i8* %59, align 1, !dbg !297, !tbaa !220
  %210 = zext i8 %209 to i32, !dbg !297
  %211 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %208, i32 4, i32 %210) #3, !dbg !297
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %208) #3, !dbg !298
  br label %212

; <label>:212:                                    ; preds = %193, %192
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %45) #3, !dbg !299
  br label %213

; <label>:213:                                    ; preds = %212, %36, %32
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %25) #3, !dbg !299
  br label %214

; <label>:214:                                    ; preds = %1, %213
  ret i32 2, !dbg !299
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
!38 = distinct !DIGlobalVariable(name: "routes", scope: !2, file: !3, line: 50, type: !24, isLocal: false, isDefinition: true)
!39 = !DIGlobalVariableExpression(var: !40, expr: !DIExpression())
!40 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 168, type: !41, isLocal: false, isDefinition: true)
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
!62 = distinct !DISubprogram(name: "xdp_pass_func", scope: !3, file: !3, line: 60, type: !63, isLocal: false, isDefinition: true, scopeLine: 61, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !74)
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
!74 = !{!75, !76, !77, !78, !90, !91, !93, !112, !113, !124, !129, !136, !137, !139, !145, !146, !148, !153, !159, !161, !163, !165}
!75 = !DILocalVariable(name: "ctx", arg: 1, scope: !62, file: !3, line: 60, type: !65)
!76 = !DILocalVariable(name: "data", scope: !62, file: !3, line: 62, type: !14)
!77 = !DILocalVariable(name: "data_end", scope: !62, file: !3, line: 63, type: !14)
!78 = !DILocalVariable(name: "eth", scope: !62, file: !3, line: 64, type: !79)
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
!90 = !DILocalVariable(name: "int_key", scope: !62, file: !3, line: 71, type: !55)
!91 = !DILocalVariable(name: "int_val", scope: !62, file: !3, line: 72, type: !92)
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!93 = !DILocalVariable(name: "ip", scope: !62, file: !3, line: 82, type: !94)
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
!112 = !DILocalVariable(name: "dst_ip", scope: !62, file: !3, line: 87, type: !69)
!113 = !DILocalVariable(name: "key4", scope: !62, file: !3, line: 92, type: !114)
!114 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !62, file: !3, line: 89, size: 64, elements: !115)
!115 = !{!116, !120}
!116 = !DIDerivedType(tag: DW_TAG_member, name: "b32", scope: !114, file: !3, line: 90, baseType: !117, size: 64)
!117 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 64, elements: !118)
!118 = !{!119}
!119 = !DISubrange(count: 2)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "b8", scope: !114, file: !3, line: 91, baseType: !121, size: 64)
!121 = !DICompositeType(tag: DW_TAG_array_type, baseType: !99, size: 64, elements: !122)
!122 = !{!123}
!123 = !DISubrange(count: 8)
!124 = !DILocalVariable(name: "val", scope: !62, file: !3, line: 93, type: !125)
!125 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !126, size: 64)
!126 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "lpm_val", file: !3, line: 45, size: 8, elements: !127)
!127 = !{!128}
!128 = !DIDerivedType(tag: DW_TAG_member, name: "flags", scope: !126, file: !3, line: 46, baseType: !99, size: 8)
!129 = !DILocalVariable(name: "____fmt", scope: !130, file: !3, line: 104, type: !133)
!130 = distinct !DILexicalBlock(scope: !131, file: !3, line: 104, column: 3)
!131 = distinct !DILexicalBlock(scope: !132, file: !3, line: 103, column: 12)
!132 = distinct !DILexicalBlock(scope: !62, file: !3, line: 103, column: 8)
!133 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 176, elements: !134)
!134 = !{!135}
!135 = !DISubrange(count: 22)
!136 = !DILocalVariable(name: "ifaceno", scope: !131, file: !3, line: 105, type: !55)
!137 = !DILocalVariable(name: "srcmac_addr", scope: !131, file: !3, line: 106, type: !138)
!138 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !99, size: 64)
!139 = !DILocalVariable(name: "buffer", scope: !140, file: !3, line: 109, type: !142)
!140 = distinct !DILexicalBlock(scope: !141, file: !3, line: 108, column: 18)
!141 = distinct !DILexicalBlock(scope: !131, file: !3, line: 108, column: 6)
!142 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 240, elements: !143)
!143 = !{!144}
!144 = !DISubrange(count: 30)
!145 = !DILocalVariable(name: "run", scope: !140, file: !3, line: 110, type: !55)
!146 = !DILocalVariable(name: "p", scope: !147, file: !3, line: 117, type: !55)
!147 = distinct !DILexicalBlock(scope: !140, file: !3, line: 117, column: 4)
!148 = !DILocalVariable(name: "____fmt", scope: !149, file: !3, line: 136, type: !150)
!149 = distinct !DILexicalBlock(scope: !140, file: !3, line: 136, column: 4)
!150 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 160, elements: !151)
!151 = !{!152}
!152 = !DISubrange(count: 20)
!153 = !DILocalVariable(name: "____fmt", scope: !154, file: !3, line: 139, type: !156)
!154 = distinct !DILexicalBlock(scope: !155, file: !3, line: 139, column: 3)
!155 = distinct !DILexicalBlock(scope: !132, file: !3, line: 138, column: 7)
!156 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 136, elements: !157)
!157 = !{!158}
!158 = !DISubrange(count: 17)
!159 = !DILocalVariable(name: "____fmt", scope: !160, file: !3, line: 140, type: !41)
!160 = distinct !DILexicalBlock(scope: !155, file: !3, line: 140, column: 3)
!161 = !DILocalVariable(name: "____fmt", scope: !162, file: !3, line: 141, type: !41)
!162 = distinct !DILexicalBlock(scope: !155, file: !3, line: 141, column: 6)
!163 = !DILocalVariable(name: "____fmt", scope: !164, file: !3, line: 142, type: !41)
!164 = distinct !DILexicalBlock(scope: !155, file: !3, line: 142, column: 6)
!165 = !DILocalVariable(name: "____fmt", scope: !166, file: !3, line: 143, type: !41)
!166 = distinct !DILexicalBlock(scope: !155, file: !3, line: 143, column: 6)
!167 = !DILocation(line: 60, column: 35, scope: !62)
!168 = !DILocation(line: 62, column: 34, scope: !62)
!169 = !{!170, !171, i64 0}
!170 = !{!"xdp_md", !171, i64 0, !171, i64 4, !171, i64 8, !171, i64 12, !171, i64 16}
!171 = !{!"int", !172, i64 0}
!172 = !{!"omnipotent char", !173, i64 0}
!173 = !{!"Simple C/C++ TBAA"}
!174 = !DILocation(line: 62, column: 23, scope: !62)
!175 = !DILocation(line: 62, column: 15, scope: !62)
!176 = !DILocation(line: 62, column: 8, scope: !62)
!177 = !DILocation(line: 63, column: 38, scope: !62)
!178 = !{!170, !171, i64 4}
!179 = !DILocation(line: 63, column: 27, scope: !62)
!180 = !DILocation(line: 63, column: 19, scope: !62)
!181 = !DILocation(line: 63, column: 8, scope: !62)
!182 = !DILocation(line: 64, column: 23, scope: !62)
!183 = !DILocation(line: 64, column: 17, scope: !62)
!184 = !DILocation(line: 67, column: 11, scope: !185)
!185 = distinct !DILexicalBlock(scope: !62, file: !3, line: 67, column: 6)
!186 = !DILocation(line: 67, column: 35, scope: !185)
!187 = !DILocation(line: 67, column: 6, scope: !62)
!188 = !DILocation(line: 71, column: 5, scope: !62)
!189 = !DILocation(line: 71, column: 9, scope: !62)
!190 = !{!171, !171, i64 0}
!191 = !DILocation(line: 73, column: 15, scope: !62)
!192 = !DILocation(line: 72, column: 10, scope: !62)
!193 = !DILocation(line: 74, column: 8, scope: !194)
!194 = distinct !DILexicalBlock(scope: !62, file: !3, line: 74, column: 8)
!195 = !DILocation(line: 74, column: 8, scope: !62)
!196 = !DILocation(line: 75, column: 19, scope: !197)
!197 = distinct !DILexicalBlock(scope: !194, file: !3, line: 74, column: 16)
!198 = !DILocation(line: 76, column: 2, scope: !197)
!199 = !DILocation(line: 79, column: 11, scope: !200)
!200 = distinct !DILexicalBlock(scope: !62, file: !3, line: 79, column: 6)
!201 = !{!202, !203, i64 12}
!202 = !{!"ethhdr", !172, i64 0, !172, i64 6, !203, i64 12}
!203 = !{!"short", !172, i64 0}
!204 = !DILocation(line: 79, column: 19, scope: !200)
!205 = !DILocation(line: 79, column: 6, scope: !62)
!206 = !DILocation(line: 82, column: 21, scope: !62)
!207 = !DILocation(line: 84, column: 8, scope: !208)
!208 = distinct !DILexicalBlock(scope: !62, file: !3, line: 84, column: 5)
!209 = !DILocation(line: 84, column: 33, scope: !208)
!210 = !DILocation(line: 84, column: 31, scope: !208)
!211 = !DILocation(line: 84, column: 5, scope: !62)
!212 = !DILocation(line: 87, column: 21, scope: !62)
!213 = !{!214, !171, i64 16}
!214 = !{!"iphdr", !172, i64 0, !172, i64 0, !172, i64 1, !203, i64 2, !203, i64 4, !203, i64 6, !172, i64 8, !172, i64 9, !203, i64 10, !171, i64 12, !171, i64 16}
!215 = !DILocation(line: 87, column: 8, scope: !62)
!216 = !DILocation(line: 89, column: 2, scope: !62)
!217 = !DILocation(line: 93, column: 21, scope: !62)
!218 = !DILocation(line: 95, column: 2, scope: !62)
!219 = !DILocation(line: 95, column: 14, scope: !62)
!220 = !{!172, !172, i64 0}
!221 = !DILocation(line: 96, column: 15, scope: !62)
!222 = !DILocation(line: 96, column: 7, scope: !62)
!223 = !DILocation(line: 96, column: 2, scope: !62)
!224 = !DILocation(line: 96, column: 13, scope: !62)
!225 = !DILocation(line: 97, column: 23, scope: !62)
!226 = !DILocation(line: 97, column: 15, scope: !62)
!227 = !DILocation(line: 97, column: 2, scope: !62)
!228 = !DILocation(line: 97, column: 13, scope: !62)
!229 = !DILocation(line: 98, column: 23, scope: !62)
!230 = !DILocation(line: 98, column: 15, scope: !62)
!231 = !DILocation(line: 98, column: 2, scope: !62)
!232 = !DILocation(line: 98, column: 13, scope: !62)
!233 = !DILocation(line: 99, column: 23, scope: !62)
!234 = !DILocation(line: 99, column: 15, scope: !62)
!235 = !DILocation(line: 99, column: 2, scope: !62)
!236 = !DILocation(line: 99, column: 13, scope: !62)
!237 = !DILocation(line: 102, column: 11, scope: !62)
!238 = !DILocation(line: 103, column: 8, scope: !132)
!239 = !DILocation(line: 103, column: 8, scope: !62)
!240 = !DILocation(line: 104, column: 3, scope: !130)
!241 = !{!242, !172, i64 0}
!242 = !{!"lpm_val", !172, i64 0}
!243 = !DILocation(line: 104, column: 3, scope: !131)
!244 = !DILocation(line: 105, column: 3, scope: !131)
!245 = !DILocation(line: 105, column: 7, scope: !131)
!246 = !DILocation(line: 107, column: 17, scope: !131)
!247 = !DILocation(line: 106, column: 9, scope: !131)
!248 = !DILocation(line: 108, column: 6, scope: !141)
!249 = !DILocation(line: 108, column: 6, scope: !131)
!250 = !DILocation(line: 109, column: 4, scope: !140)
!251 = !DILocation(line: 109, column: 9, scope: !140)
!252 = !DILocation(line: 110, column: 8, scope: !140)
!253 = !DILocation(line: 117, column: 12, scope: !147)
!254 = !DILocation(line: 118, column: 10, scope: !255)
!255 = distinct !DILexicalBlock(scope: !256, file: !3, line: 118, column: 9)
!256 = distinct !DILexicalBlock(scope: !257, file: !3, line: 117, column: 30)
!257 = distinct !DILexicalBlock(scope: !147, file: !3, line: 117, column: 4)
!258 = !DILocation(line: 118, column: 24, scope: !255)
!259 = !DILocation(line: 118, column: 29, scope: !255)
!260 = !DILocation(line: 121, column: 40, scope: !261)
!261 = distinct !DILexicalBlock(scope: !255, file: !3, line: 120, column: 10)
!262 = !DILocation(line: 119, column: 45, scope: !263)
!263 = distinct !DILexicalBlock(scope: !255, file: !3, line: 118, column: 35)
!264 = !DILocation(line: 118, column: 9, scope: !256)
!265 = !DILocation(line: 121, column: 18, scope: !261)
!266 = !DILocation(line: 124, column: 10, scope: !267)
!267 = distinct !DILexicalBlock(scope: !256, file: !3, line: 124, column: 9)
!268 = !DILocation(line: 124, column: 24, scope: !267)
!269 = !DILocation(line: 124, column: 31, scope: !267)
!270 = !DILocation(line: 127, column: 42, scope: !271)
!271 = distinct !DILexicalBlock(scope: !267, file: !3, line: 126, column: 10)
!272 = !DILocation(line: 125, column: 47, scope: !273)
!273 = distinct !DILexicalBlock(scope: !267, file: !3, line: 124, column: 37)
!274 = !DILocation(line: 124, column: 9, scope: !256)
!275 = !DILocation(line: 127, column: 6, scope: !271)
!276 = !DILocation(line: 127, column: 18, scope: !271)
!277 = !DILocation(line: 131, column: 6, scope: !278)
!278 = distinct !DILexicalBlock(scope: !279, file: !3, line: 129, column: 15)
!279 = distinct !DILexicalBlock(scope: !256, file: !3, line: 129, column: 8)
!280 = !DILocation(line: 131, column: 18, scope: !278)
!281 = !DILocation(line: 135, column: 4, scope: !140)
!282 = !DILocation(line: 135, column: 16, scope: !140)
!283 = !DILocation(line: 136, column: 4, scope: !149)
!284 = !DILocation(line: 136, column: 4, scope: !140)
!285 = !DILocation(line: 137, column: 3, scope: !141)
!286 = !DILocation(line: 137, column: 3, scope: !140)
!287 = !DILocation(line: 138, column: 2, scope: !132)
!288 = !DILocation(line: 138, column: 2, scope: !131)
!289 = !DILocation(line: 139, column: 3, scope: !154)
!290 = !DILocation(line: 139, column: 3, scope: !155)
!291 = !DILocation(line: 140, column: 3, scope: !160)
!292 = !DILocation(line: 140, column: 3, scope: !155)
!293 = !DILocation(line: 141, column: 6, scope: !162)
!294 = !DILocation(line: 141, column: 6, scope: !155)
!295 = !DILocation(line: 142, column: 6, scope: !164)
!296 = !DILocation(line: 142, column: 6, scope: !155)
!297 = !DILocation(line: 143, column: 6, scope: !166)
!298 = !DILocation(line: 143, column: 6, scope: !155)
!299 = !DILocation(line: 166, column: 1, scope: !62)
