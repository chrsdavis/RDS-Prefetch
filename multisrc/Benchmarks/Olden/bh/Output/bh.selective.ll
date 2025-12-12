; ModuleID = 'Output/bh.selective.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.datapoints = type { [3 x double], [3 x double], ptr, ptr }
%struct.icstruct = type { [3 x i32], i16 }
%struct.tree = type { [3 x double], double, ptr, [64 x ptr], [64 x ptr] }
%struct.bnode = type { i16, double, [3 x double], i32, i32, [3 x double], [3 x double], [3 x double], double, ptr, ptr }
%struct.hgstruct = type { ptr, [3 x double], double, [3 x double] }
%struct.cnode = type { i16, double, [3 x double], i32, i32, [8 x ptr], ptr }
%struct.node = type { i16, double, [3 x double], i32, i32 }

@.str = private unnamed_addr constant [27 x i8] c"nbody = %d, numnodes = %d\0A\00", align 1
@nbody = common dso_local global i32 0, align 4
@.str.1 = private unnamed_addr constant [17 x i8] c"bodies created \0A\00", align 1
@.str.2 = private unnamed_addr constant [20 x i8] c"Bodies per %d = %d\0A\00", align 1
@.str.3 = private unnamed_addr constant [22 x i8] c"Assertion Failure #%d\00", align 1
@cp_free_list = dso_local global ptr null, align 8
@bp_free_list = dso_local global ptr null, align 8
@.str.4 = private unnamed_addr constant [29 x i8] c"testdata: not enough memory\0A\00", align 1
@.str.5 = private unnamed_addr constant [24 x i8] c"%2d BODY@%x %f, %f, %f\0A\00", align 1
@.str.6 = private unnamed_addr constant [24 x i8] c"%2d CELL@%x %f, %f, %f\0A\00", align 1
@.str.7 = private unnamed_addr constant [15 x i8] c"%2d NULL TREE\0A\00", align 1
@arg1 = common dso_local global i32 0, align 4
@stderr = external global ptr, align 8
@.str.11 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str.1.12 = private unnamed_addr constant [6 x i8] c"Error\00", align 1
@NumNodes = common dso_local global i32 0, align 4
@root = common dso_local global ptr null, align 8
@rmin = common dso_local global [3 x double] zeroinitializer, align 16
@xxxrsize = common dso_local global double 0.000000e+00, align 8

; Function Attrs: nounwind uwtable
define dso_local i32 @dealwithargs(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store i32 %0, ptr %3, align 4, !tbaa !5
  store ptr %1, ptr %4, align 8, !tbaa !9
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #11
  %6 = load i32, ptr %3, align 4, !tbaa !5
  %7 = icmp sgt i32 %6, 2
  br i1 %7, label %8, label %13

8:                                                ; preds = %2
  %9 = load ptr, ptr %4, align 8, !tbaa !9
  %10 = getelementptr inbounds ptr, ptr %9, i64 2
  %11 = load ptr, ptr %10, align 8, !tbaa !12
  %12 = call i32 @atoi(ptr noundef %11) #12
  store i32 %12, ptr @NumNodes, align 4, !tbaa !5
  br label %14

13:                                               ; preds = %2
  store i32 4, ptr @NumNodes, align 4, !tbaa !5
  br label %14

14:                                               ; preds = %13, %8
  %15 = load i32, ptr %3, align 4, !tbaa !5
  %16 = icmp sgt i32 %15, 1
  br i1 %16, label %17, label %22

17:                                               ; preds = %14
  %18 = load ptr, ptr %4, align 8, !tbaa !9
  %19 = getelementptr inbounds ptr, ptr %18, i64 1
  %20 = load ptr, ptr %19, align 8, !tbaa !12
  %21 = call i32 @atoi(ptr noundef %20) #12
  store i32 %21, ptr @nbody, align 4, !tbaa !5
  br label %23

22:                                               ; preds = %14
  store i32 32, ptr @nbody, align 4, !tbaa !5
  br label %23

23:                                               ; preds = %22, %17
  %24 = load i32, ptr %5, align 4, !tbaa !5
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #11
  ret i32 %24
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: inlinehint nounwind willreturn memory(read) uwtable
define available_externally i32 @atoi(ptr noundef nonnull %0) #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8, !tbaa !12
  %3 = load ptr, ptr %2, align 8, !tbaa !12
  %4 = call i64 @strtol(ptr noundef %3, ptr noundef null, i32 noundef 10) #11
  %5 = trunc i64 %4 to i32
  ret i32 %5
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i64 @strtol(ptr noundef, ptr noundef, i32 noundef) #3

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4, !tbaa !5
  store ptr %1, ptr %5, align 8, !tbaa !9
  call void @llvm.lifetime.start.p0(i64 8, ptr %6) #11
  %7 = load i32, ptr %4, align 4, !tbaa !5
  %8 = load ptr, ptr %5, align 8, !tbaa !9
  %9 = call i32 (i32, ptr, ...) @dealwithargs(i32 noundef %7, ptr noundef %8)
  %10 = load i32, ptr @nbody, align 4, !tbaa !5
  %11 = load i32, ptr @NumNodes, align 4, !tbaa !5
  %12 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %10, i32 noundef %11)
  %13 = call ptr @old_main()
  store ptr %13, ptr %6, align 8, !tbaa !14
  call void @llvm.lifetime.end.p0(i64 8, ptr %6) #11
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #4

; Function Attrs: nounwind uwtable
define dso_local ptr @old_main() #0 {
  %1 = alloca double, align 8
  %2 = alloca double, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  %11 = alloca [3 x double], align 16
  %12 = alloca [3 x double], align 16
  %13 = alloca ptr, align 8
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca [64 x i32], align 16
  %17 = alloca [64 x ptr], align 16
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca %struct.datapoints, align 8
  %21 = alloca i32, align 4
  %22 = alloca %struct.datapoints, align 8
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca %struct.icstruct, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca %struct.icstruct, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr %1) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %2) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %3) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %6) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %7) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %8) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %9) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %10) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %11) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %12) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %13) #11
  store ptr null, ptr %13, align 8, !tbaa !15
  call void @llvm.lifetime.start.p0(i64 4, ptr %14) #11
  store i32 0, ptr %14, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 4, ptr %15) #11
  %31 = load i32, ptr @NumNodes, align 4, !tbaa !5
  %32 = sdiv i32 64, %31
  store i32 %32, ptr %15, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 256, ptr %16) #11
  call void @llvm.lifetime.start.p0(i64 512, ptr %17) #11
  call void @srand(i32 noundef 123) #11
  %33 = call noalias ptr @malloc(i64 noundef 1064) #13
  store ptr %33, ptr %6, align 8, !tbaa !14
  %34 = load ptr, ptr %6, align 8, !tbaa !14
  %35 = getelementptr inbounds nuw %struct.tree, ptr %34, i32 0, i32 2
  store ptr null, ptr %35, align 8, !tbaa !17
  %36 = load ptr, ptr %6, align 8, !tbaa !14
  %37 = getelementptr inbounds nuw %struct.tree, ptr %36, i32 0, i32 0
  %38 = getelementptr inbounds [3 x double], ptr %37, i64 0, i64 0
  store double -2.000000e+00, ptr %38, align 8, !tbaa !21
  %39 = load ptr, ptr %6, align 8, !tbaa !14
  %40 = getelementptr inbounds nuw %struct.tree, ptr %39, i32 0, i32 0
  %41 = getelementptr inbounds [3 x double], ptr %40, i64 0, i64 1
  store double -2.000000e+00, ptr %41, align 8, !tbaa !21
  %42 = load ptr, ptr %6, align 8, !tbaa !14
  %43 = getelementptr inbounds nuw %struct.tree, ptr %42, i32 0, i32 0
  %44 = getelementptr inbounds [3 x double], ptr %43, i64 0, i64 2
  store double -2.000000e+00, ptr %44, align 8, !tbaa !21
  %45 = load ptr, ptr %6, align 8, !tbaa !14
  %46 = getelementptr inbounds nuw %struct.tree, ptr %45, i32 0, i32 1
  store double 4.000000e+00, ptr %46, align 8, !tbaa !22
  call void @llvm.lifetime.start.p0(i64 4, ptr %18) #11
  store i32 0, ptr %18, align 4, !tbaa !5
  br label %47

47:                                               ; preds = %54, %0
  %48 = load i32, ptr %18, align 4, !tbaa !5
  %49 = icmp slt i32 %48, 3
  br i1 %49, label %50, label %57

50:                                               ; preds = %47
  %51 = load i32, ptr %18, align 4, !tbaa !5
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds [3 x double], ptr %11, i64 0, i64 %52
  store double 0.000000e+00, ptr %53, align 8, !tbaa !21
  br label %54

54:                                               ; preds = %50
  %55 = load i32, ptr %18, align 4, !tbaa !5
  %56 = add nsw i32 %55, 1
  store i32 %56, ptr %18, align 4, !tbaa !5
  br label %47, !llvm.loop !23

57:                                               ; preds = %47
  call void @llvm.lifetime.end.p0(i64 4, ptr %18) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %19) #11
  store i32 0, ptr %19, align 4, !tbaa !5
  br label %58

58:                                               ; preds = %65, %57
  %59 = load i32, ptr %19, align 4, !tbaa !5
  %60 = icmp slt i32 %59, 3
  br i1 %60, label %61, label %68

61:                                               ; preds = %58
  %62 = load i32, ptr %19, align 4, !tbaa !5
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds [3 x double], ptr %12, i64 0, i64 %63
  store double 0.000000e+00, ptr %64, align 8, !tbaa !21
  br label %65

65:                                               ; preds = %61
  %66 = load i32, ptr %19, align 4, !tbaa !5
  %67 = add nsw i32 %66, 1
  store i32 %67, ptr %19, align 4, !tbaa !5
  br label %58, !llvm.loop !25

68:                                               ; preds = %58
  call void @llvm.lifetime.end.p0(i64 4, ptr %19) #11
  store i32 0, ptr %3, align 4, !tbaa !5
  br label %69

69:                                               ; preds = %141, %68
  %70 = load i32, ptr %3, align 4, !tbaa !5
  %71 = icmp slt i32 %70, 32
  br i1 %71, label %72, label %144

72:                                               ; preds = %69
  call void @llvm.lifetime.start.p0(i64 64, ptr %20) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %21) #11
  %73 = load i32, ptr %3, align 4, !tbaa !5
  %74 = load i32, ptr @NumNodes, align 4, !tbaa !5
  %75 = sdiv i32 32, %74
  %76 = sdiv i32 %73, %75
  store i32 %76, ptr %21, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 64, ptr %22) #11
  %77 = load i32, ptr %21, align 4, !tbaa !5
  %78 = load i32, ptr @nbody, align 4, !tbaa !5
  %79 = sdiv i32 %78, 32
  %80 = load i32, ptr %3, align 4, !tbaa !5
  %81 = add nsw i32 %80, 1
  call void @uniform_testdata(ptr dead_on_unwind writable sret(%struct.datapoints) align 8 %22, i32 noundef %77, i32 noundef %79, i32 noundef %81)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %20, ptr align 8 %22, i64 64, i1 false), !tbaa.struct !26
  call void @llvm.lifetime.end.p0(i64 64, ptr %22) #11
  %82 = getelementptr inbounds nuw %struct.datapoints, ptr %20, i32 0, i32 2
  %83 = load ptr, ptr %82, align 8, !tbaa !28
  %84 = load ptr, ptr %6, align 8, !tbaa !14
  %rds.field.ptr15 = getelementptr inbounds %struct.tree, ptr %84, i32 0, i32 2
  %rds.field.val16 = load ptr, ptr %rds.field.ptr15, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val16, i32 0, i32 3, i32 1)
  %rds.field.ptr17 = getelementptr inbounds %struct.tree, ptr %84, i32 0, i32 4
  %rds.field.val18 = load ptr, ptr %rds.field.ptr17, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val18, i32 0, i32 3, i32 1)
  %85 = getelementptr inbounds nuw %struct.tree, ptr %84, i32 0, i32 3
  %86 = load i32, ptr %3, align 4, !tbaa !5
  %87 = sext i32 %86 to i64
  %88 = getelementptr inbounds [64 x ptr], ptr %85, i64 0, i64 %87
  store ptr %83, ptr %88, align 8, !tbaa !15
  %89 = load ptr, ptr %13, align 8, !tbaa !15
  %90 = icmp ne ptr %89, null
  br i1 %90, label %91, label %96

91:                                               ; preds = %72
  %92 = getelementptr inbounds nuw %struct.datapoints, ptr %20, i32 0, i32 2
  %93 = load ptr, ptr %92, align 8, !tbaa !28
  %94 = load ptr, ptr %13, align 8, !tbaa !15
  %rds.field.ptr19 = getelementptr inbounds %struct.bnode, ptr %94, i32 0, i32 10
  %rds.field.val20 = load ptr, ptr %rds.field.ptr19, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val20, i32 0, i32 3, i32 1)
  %95 = getelementptr inbounds nuw %struct.bnode, ptr %94, i32 0, i32 9
  store ptr %93, ptr %95, align 8, !tbaa !30
  br label %96

96:                                               ; preds = %91, %72
  %97 = getelementptr inbounds nuw %struct.datapoints, ptr %20, i32 0, i32 3
  %98 = load ptr, ptr %97, align 8, !tbaa !33
  store ptr %98, ptr %13, align 8, !tbaa !15
  call void @llvm.lifetime.start.p0(i64 4, ptr %23) #11
  store i32 0, ptr %23, align 4, !tbaa !5
  br label %99

99:                                               ; preds = %116, %96
  %100 = load i32, ptr %23, align 4, !tbaa !5
  %101 = icmp slt i32 %100, 3
  br i1 %101, label %102, label %119

102:                                              ; preds = %99
  %103 = load i32, ptr %23, align 4, !tbaa !5
  %104 = sext i32 %103 to i64
  %105 = getelementptr inbounds [3 x double], ptr %11, i64 0, i64 %104
  %106 = load double, ptr %105, align 8, !tbaa !21
  %107 = getelementptr inbounds nuw %struct.datapoints, ptr %20, i32 0, i32 0
  %108 = load i32, ptr %23, align 4, !tbaa !5
  %109 = sext i32 %108 to i64
  %110 = getelementptr inbounds [3 x double], ptr %107, i64 0, i64 %109
  %111 = load double, ptr %110, align 8, !tbaa !21
  %112 = fadd double %106, %111
  %113 = load i32, ptr %23, align 4, !tbaa !5
  %114 = sext i32 %113 to i64
  %115 = getelementptr inbounds [3 x double], ptr %11, i64 0, i64 %114
  store double %112, ptr %115, align 8, !tbaa !21
  br label %116

116:                                              ; preds = %102
  %117 = load i32, ptr %23, align 4, !tbaa !5
  %118 = add nsw i32 %117, 1
  store i32 %118, ptr %23, align 4, !tbaa !5
  br label %99, !llvm.loop !34

119:                                              ; preds = %99
  call void @llvm.lifetime.end.p0(i64 4, ptr %23) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %24) #11
  store i32 0, ptr %24, align 4, !tbaa !5
  br label %120

120:                                              ; preds = %137, %119
  %121 = load i32, ptr %24, align 4, !tbaa !5
  %122 = icmp slt i32 %121, 3
  br i1 %122, label %123, label %140

123:                                              ; preds = %120
  %124 = load i32, ptr %24, align 4, !tbaa !5
  %125 = sext i32 %124 to i64
  %126 = getelementptr inbounds [3 x double], ptr %12, i64 0, i64 %125
  %127 = load double, ptr %126, align 8, !tbaa !21
  %128 = getelementptr inbounds nuw %struct.datapoints, ptr %20, i32 0, i32 1
  %129 = load i32, ptr %24, align 4, !tbaa !5
  %130 = sext i32 %129 to i64
  %131 = getelementptr inbounds [3 x double], ptr %128, i64 0, i64 %130
  %132 = load double, ptr %131, align 8, !tbaa !21
  %133 = fadd double %127, %132
  %134 = load i32, ptr %24, align 4, !tbaa !5
  %135 = sext i32 %134 to i64
  %136 = getelementptr inbounds [3 x double], ptr %12, i64 0, i64 %135
  store double %133, ptr %136, align 8, !tbaa !21
  br label %137

137:                                              ; preds = %123
  %138 = load i32, ptr %24, align 4, !tbaa !5
  %139 = add nsw i32 %138, 1
  store i32 %139, ptr %24, align 4, !tbaa !5
  br label %120, !llvm.loop !35

140:                                              ; preds = %120
  call void @llvm.lifetime.end.p0(i64 4, ptr %24) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %21) #11
  call void @llvm.lifetime.end.p0(i64 64, ptr %20) #11
  br label %141

141:                                              ; preds = %140
  %142 = load i32, ptr %3, align 4, !tbaa !5
  %143 = add nsw i32 %142, 1
  store i32 %143, ptr %3, align 4, !tbaa !5
  br label %69, !llvm.loop !36

144:                                              ; preds = %69
  %145 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  call void @llvm.lifetime.start.p0(i64 4, ptr %25) #11
  store i32 0, ptr %25, align 4, !tbaa !5
  br label %146

146:                                              ; preds = %160, %144
  %147 = load i32, ptr %25, align 4, !tbaa !5
  %148 = icmp slt i32 %147, 3
  br i1 %148, label %149, label %163

149:                                              ; preds = %146
  %150 = load i32, ptr %25, align 4, !tbaa !5
  %151 = sext i32 %150 to i64
  %152 = getelementptr inbounds [3 x double], ptr %11, i64 0, i64 %151
  %153 = load double, ptr %152, align 8, !tbaa !21
  %154 = load i32, ptr @nbody, align 4, !tbaa !5
  %155 = sitofp i32 %154 to double
  %156 = fdiv double %153, %155
  %157 = load i32, ptr %25, align 4, !tbaa !5
  %158 = sext i32 %157 to i64
  %159 = getelementptr inbounds [3 x double], ptr %11, i64 0, i64 %158
  store double %156, ptr %159, align 8, !tbaa !21
  br label %160

160:                                              ; preds = %149
  %161 = load i32, ptr %25, align 4, !tbaa !5
  %162 = add nsw i32 %161, 1
  store i32 %162, ptr %25, align 4, !tbaa !5
  br label %146, !llvm.loop !37

163:                                              ; preds = %146
  call void @llvm.lifetime.end.p0(i64 4, ptr %25) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %26) #11
  store i32 0, ptr %26, align 4, !tbaa !5
  br label %164

164:                                              ; preds = %178, %163
  %165 = load i32, ptr %26, align 4, !tbaa !5
  %166 = icmp slt i32 %165, 3
  br i1 %166, label %167, label %181

167:                                              ; preds = %164
  %168 = load i32, ptr %26, align 4, !tbaa !5
  %169 = sext i32 %168 to i64
  %170 = getelementptr inbounds [3 x double], ptr %12, i64 0, i64 %169
  %171 = load double, ptr %170, align 8, !tbaa !21
  %172 = load i32, ptr @nbody, align 4, !tbaa !5
  %173 = sitofp i32 %172 to double
  %174 = fdiv double %171, %173
  %175 = load i32, ptr %26, align 4, !tbaa !5
  %176 = sext i32 %175 to i64
  %177 = getelementptr inbounds [3 x double], ptr %12, i64 0, i64 %176
  store double %174, ptr %177, align 8, !tbaa !21
  br label %178

178:                                              ; preds = %167
  %179 = load i32, ptr %26, align 4, !tbaa !5
  %180 = add nsw i32 %179, 1
  store i32 %180, ptr %26, align 4, !tbaa !5
  br label %164, !llvm.loop !38

181:                                              ; preds = %164
  call void @llvm.lifetime.end.p0(i64 4, ptr %26) #11
  store i32 0, ptr %14, align 4, !tbaa !5
  br label %182

182:                                              ; preds = %192, %181
  %183 = load i32, ptr %14, align 4, !tbaa !5
  %184 = icmp slt i32 %183, 64
  br i1 %184, label %185, label %195

185:                                              ; preds = %182
  %186 = load i32, ptr %14, align 4, !tbaa !5
  %187 = sext i32 %186 to i64
  %188 = getelementptr inbounds [64 x i32], ptr %16, i64 0, i64 %187
  store i32 0, ptr %188, align 4, !tbaa !5
  %189 = load i32, ptr %14, align 4, !tbaa !5
  %190 = sext i32 %189 to i64
  %191 = getelementptr inbounds [64 x ptr], ptr %17, i64 0, i64 %190
  store ptr null, ptr %191, align 8, !tbaa !15
  br label %192

192:                                              ; preds = %185
  %193 = load i32, ptr %14, align 4, !tbaa !5
  %194 = add nsw i32 %193, 1
  store i32 %194, ptr %14, align 4, !tbaa !5
  br label %182, !llvm.loop !39

195:                                              ; preds = %182
  %196 = load ptr, ptr %6, align 8, !tbaa !14
  %197 = getelementptr inbounds nuw %struct.tree, ptr %196, i32 0, i32 3
  %198 = getelementptr inbounds [64 x ptr], ptr %197, i64 0, i64 0
  %199 = load ptr, ptr %198, align 8, !tbaa !15
  store ptr %199, ptr %8, align 8, !tbaa !15
  br label %200

200:                                              ; preds = %292, %195
  %201 = load ptr, ptr %8, align 8, !tbaa !15
  %202 = icmp ne ptr %201, null
  br i1 %202, label %203, label %296

203:                                              ; preds = %200
  call void @llvm.lifetime.start.p0(i64 16, ptr %27) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %28) #11
  store i32 0, ptr %28, align 4, !tbaa !5
  br label %204

204:                                              ; preds = %224, %203
  %205 = load i32, ptr %28, align 4, !tbaa !5
  %206 = icmp slt i32 %205, 3
  br i1 %206, label %207, label %227

207:                                              ; preds = %204
  %208 = load ptr, ptr %8, align 8, !tbaa !15
  %rds.field.ptr11 = getelementptr inbounds %struct.bnode, ptr %208, i32 0, i32 9
  %rds.field.val12 = load ptr, ptr %rds.field.ptr11, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val12, i32 0, i32 3, i32 1)
  %rds.field.ptr13 = getelementptr inbounds %struct.bnode, ptr %208, i32 0, i32 10
  %rds.field.val14 = load ptr, ptr %rds.field.ptr13, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val14, i32 0, i32 3, i32 1)
  %209 = getelementptr inbounds nuw %struct.bnode, ptr %208, i32 0, i32 2
  %210 = load i32, ptr %28, align 4, !tbaa !5
  %211 = sext i32 %210 to i64
  %212 = getelementptr inbounds [3 x double], ptr %209, i64 0, i64 %211
  %213 = load double, ptr %212, align 8, !tbaa !21
  %214 = load i32, ptr %28, align 4, !tbaa !5
  %215 = sext i32 %214 to i64
  %216 = getelementptr inbounds [3 x double], ptr %11, i64 0, i64 %215
  %217 = load double, ptr %216, align 8, !tbaa !21
  %218 = fsub double %213, %217
  %219 = load ptr, ptr %8, align 8, !tbaa !15
  %220 = getelementptr inbounds nuw %struct.bnode, ptr %219, i32 0, i32 2
  %221 = load i32, ptr %28, align 4, !tbaa !5
  %222 = sext i32 %221 to i64
  %223 = getelementptr inbounds [3 x double], ptr %220, i64 0, i64 %222
  store double %218, ptr %223, align 8, !tbaa !21
  br label %224

224:                                              ; preds = %207
  %225 = load i32, ptr %28, align 4, !tbaa !5
  %226 = add nsw i32 %225, 1
  store i32 %226, ptr %28, align 4, !tbaa !5
  br label %204, !llvm.loop !40

227:                                              ; preds = %204
  call void @llvm.lifetime.end.p0(i64 4, ptr %28) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %29) #11
  store i32 0, ptr %29, align 4, !tbaa !5
  br label %228

228:                                              ; preds = %248, %227
  %229 = load i32, ptr %29, align 4, !tbaa !5
  %230 = icmp slt i32 %229, 3
  br i1 %230, label %231, label %251

231:                                              ; preds = %228
  %232 = load ptr, ptr %8, align 8, !tbaa !15
  %rds.field.ptr7 = getelementptr inbounds %struct.bnode, ptr %232, i32 0, i32 9
  %rds.field.val8 = load ptr, ptr %rds.field.ptr7, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val8, i32 0, i32 3, i32 1)
  %rds.field.ptr9 = getelementptr inbounds %struct.bnode, ptr %232, i32 0, i32 10
  %rds.field.val10 = load ptr, ptr %rds.field.ptr9, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val10, i32 0, i32 3, i32 1)
  %233 = getelementptr inbounds nuw %struct.bnode, ptr %232, i32 0, i32 5
  %234 = load i32, ptr %29, align 4, !tbaa !5
  %235 = sext i32 %234 to i64
  %236 = getelementptr inbounds [3 x double], ptr %233, i64 0, i64 %235
  %237 = load double, ptr %236, align 8, !tbaa !21
  %238 = load i32, ptr %29, align 4, !tbaa !5
  %239 = sext i32 %238 to i64
  %240 = getelementptr inbounds [3 x double], ptr %12, i64 0, i64 %239
  %241 = load double, ptr %240, align 8, !tbaa !21
  %242 = fsub double %237, %241
  %243 = load ptr, ptr %8, align 8, !tbaa !15
  %244 = getelementptr inbounds nuw %struct.bnode, ptr %243, i32 0, i32 5
  %245 = load i32, ptr %29, align 4, !tbaa !5
  %246 = sext i32 %245 to i64
  %247 = getelementptr inbounds [3 x double], ptr %244, i64 0, i64 %246
  store double %242, ptr %247, align 8, !tbaa !21
  br label %248

248:                                              ; preds = %231
  %249 = load i32, ptr %29, align 4, !tbaa !5
  %250 = add nsw i32 %249, 1
  store i32 %250, ptr %29, align 4, !tbaa !5
  br label %228, !llvm.loop !41

251:                                              ; preds = %228
  call void @llvm.lifetime.end.p0(i64 4, ptr %29) #11
  call void @llvm.lifetime.start.p0(i64 16, ptr %30) #11
  %252 = load ptr, ptr %8, align 8, !tbaa !15
  %253 = load ptr, ptr %6, align 8, !tbaa !14
  %254 = call { i64, i64 } @intcoord(ptr noundef %252, ptr noundef %253)
  %255 = getelementptr inbounds nuw { i64, i64 }, ptr %30, i32 0, i32 0
  %256 = extractvalue { i64, i64 } %254, 0
  store i64 %256, ptr %255, align 4
  %257 = getelementptr inbounds nuw { i64, i64 }, ptr %30, i32 0, i32 1
  %258 = extractvalue { i64, i64 } %254, 1
  store i64 %258, ptr %257, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %27, ptr align 4 %30, i64 16, i1 false), !tbaa.struct !42
  call void @llvm.lifetime.end.p0(i64 16, ptr %30) #11
  %259 = getelementptr inbounds nuw { i64, i64 }, ptr %27, i32 0, i32 0
  %260 = load i64, ptr %259, align 4
  %261 = getelementptr inbounds nuw { i64, i64 }, ptr %27, i32 0, i32 1
  %262 = load i64, ptr %261, align 4
  %263 = call i32 @old_subindex(i64 %260, i64 %262, i32 noundef 536870912)
  %264 = shl i32 %263, 3
  %265 = getelementptr inbounds nuw { i64, i64 }, ptr %27, i32 0, i32 0
  %266 = load i64, ptr %265, align 4
  %267 = getelementptr inbounds nuw { i64, i64 }, ptr %27, i32 0, i32 1
  %268 = load i64, ptr %267, align 4
  %269 = call i32 @old_subindex(i64 %266, i64 %268, i32 noundef 268435456)
  %270 = add nsw i32 %264, %269
  store i32 %270, ptr %14, align 4, !tbaa !5
  %271 = load i32, ptr %14, align 4, !tbaa !5
  %272 = load i32, ptr %15, align 4, !tbaa !5
  %273 = sdiv i32 %271, %272
  store i32 %273, ptr %14, align 4, !tbaa !5
  %274 = load i32, ptr %14, align 4, !tbaa !5
  %275 = sext i32 %274 to i64
  %276 = getelementptr inbounds [64 x i32], ptr %16, i64 0, i64 %275
  %277 = load i32, ptr %276, align 4, !tbaa !5
  %278 = add nsw i32 %277, 1
  store i32 %278, ptr %276, align 4, !tbaa !5
  %279 = load i32, ptr %14, align 4, !tbaa !5
  %280 = sext i32 %279 to i64
  %281 = getelementptr inbounds [64 x ptr], ptr %17, i64 0, i64 %280
  %282 = load ptr, ptr %281, align 8, !tbaa !15
  %283 = load ptr, ptr %8, align 8, !tbaa !15
  %rds.field.ptr3 = getelementptr inbounds %struct.bnode, ptr %283, i32 0, i32 9
  %rds.field.val4 = load ptr, ptr %rds.field.ptr3, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val4, i32 0, i32 3, i32 1)
  %284 = getelementptr inbounds nuw %struct.bnode, ptr %283, i32 0, i32 10
  store ptr %282, ptr %284, align 8, !tbaa !44
  %285 = load ptr, ptr %8, align 8, !tbaa !15
  %286 = load i32, ptr %14, align 4, !tbaa !5
  %287 = sext i32 %286 to i64
  %288 = getelementptr inbounds [64 x ptr], ptr %17, i64 0, i64 %287
  store ptr %285, ptr %288, align 8, !tbaa !15
  %289 = load i32, ptr %14, align 4, !tbaa !5
  %290 = load ptr, ptr %8, align 8, !tbaa !15
  %291 = getelementptr inbounds nuw %struct.bnode, ptr %290, i32 0, i32 3
  store i32 %289, ptr %291, align 8, !tbaa !45
  call void @llvm.lifetime.end.p0(i64 16, ptr %27) #11
  br label %292

292:                                              ; preds = %251
  %293 = load ptr, ptr %8, align 8, !tbaa !15
  %rds.field.ptr5 = getelementptr inbounds %struct.bnode, ptr %293, i32 0, i32 10
  %rds.field.val6 = load ptr, ptr %rds.field.ptr5, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val6, i32 0, i32 3, i32 1)
  %294 = getelementptr inbounds nuw %struct.bnode, ptr %293, i32 0, i32 9
  %295 = load ptr, ptr %294, align 8, !tbaa !30
  store ptr %295, ptr %8, align 8, !tbaa !15
  br label %200, !llvm.loop !46

296:                                              ; preds = %200
  store i32 0, ptr %14, align 4, !tbaa !5
  br label %297

297:                                              ; preds = %317, %296
  %298 = load i32, ptr %14, align 4, !tbaa !5
  %299 = load i32, ptr @NumNodes, align 4, !tbaa !5
  %300 = icmp slt i32 %298, %299
  br i1 %300, label %301, label %320

301:                                              ; preds = %297
  %302 = load i32, ptr %14, align 4, !tbaa !5
  %303 = load i32, ptr %14, align 4, !tbaa !5
  %304 = sext i32 %303 to i64
  %305 = getelementptr inbounds [64 x i32], ptr %16, i64 0, i64 %304
  %306 = load i32, ptr %305, align 4, !tbaa !5
  %307 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %302, i32 noundef %306)
  %308 = load i32, ptr %14, align 4, !tbaa !5
  %309 = sext i32 %308 to i64
  %310 = getelementptr inbounds [64 x ptr], ptr %17, i64 0, i64 %309
  %311 = load ptr, ptr %310, align 8, !tbaa !15
  %312 = load ptr, ptr %6, align 8, !tbaa !14
  %rds.field.ptr = getelementptr inbounds %struct.tree, ptr %312, i32 0, i32 2
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %rds.field.ptr1 = getelementptr inbounds %struct.tree, ptr %312, i32 0, i32 3
  %rds.field.val2 = load ptr, ptr %rds.field.ptr1, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val2, i32 0, i32 3, i32 1)
  %313 = getelementptr inbounds nuw %struct.tree, ptr %312, i32 0, i32 4
  %314 = load i32, ptr %14, align 4, !tbaa !5
  %315 = sext i32 %314 to i64
  %316 = getelementptr inbounds [64 x ptr], ptr %313, i64 0, i64 %315
  store ptr %311, ptr %316, align 8, !tbaa !15
  br label %317

317:                                              ; preds = %301
  %318 = load i32, ptr %14, align 4, !tbaa !5
  %319 = add nsw i32 %318, 1
  store i32 %319, ptr %14, align 4, !tbaa !5
  br label %297, !llvm.loop !47

320:                                              ; preds = %297
  store i32 0, ptr %14, align 4, !tbaa !5
  store double 0.000000e+00, ptr %1, align 8, !tbaa !21
  store i32 0, ptr %3, align 4, !tbaa !5
  store i32 10, ptr %4, align 4, !tbaa !5
  br label %321

321:                                              ; preds = %330, %320
  %322 = load double, ptr %1, align 8, !tbaa !21
  %323 = fcmp olt double %322, 2.001250e+00
  br i1 %323, label %324, label %328

324:                                              ; preds = %321
  %325 = load i32, ptr %3, align 4, !tbaa !5
  %326 = load i32, ptr %4, align 4, !tbaa !5
  %327 = icmp slt i32 %325, %326
  br label %328

328:                                              ; preds = %324, %321
  %329 = phi i1 [ false, %321 ], [ %327, %324 ]
  br i1 %329, label %330, label %337

330:                                              ; preds = %328
  %331 = load ptr, ptr %6, align 8, !tbaa !14
  %332 = load i32, ptr %3, align 4, !tbaa !5
  call void @stepsystem(ptr noundef %331, i32 noundef %332)
  %333 = load double, ptr %1, align 8, !tbaa !21
  %334 = fadd double %333, 1.250000e-02
  store double %334, ptr %1, align 8, !tbaa !21
  %335 = load i32, ptr %3, align 4, !tbaa !5
  %336 = add nsw i32 %335, 1
  store i32 %336, ptr %3, align 4, !tbaa !5
  br label %321, !llvm.loop !48

337:                                              ; preds = %328
  %338 = load ptr, ptr %6, align 8, !tbaa !14
  call void @llvm.lifetime.end.p0(i64 512, ptr %17) #11
  call void @llvm.lifetime.end.p0(i64 256, ptr %16) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %15) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %14) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %13) #11
  call void @llvm.lifetime.end.p0(i64 24, ptr %12) #11
  call void @llvm.lifetime.end.p0(i64 24, ptr %11) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %10) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %9) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %8) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %7) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %6) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %3) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %2) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %1) #11
  ret ptr %338
}

; Function Attrs: nounwind
declare void @srand(i32 noundef) #3

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #5

; Function Attrs: nounwind uwtable
define dso_local void @uniform_testdata(ptr dead_on_unwind noalias writable sret(%struct.datapoints) align 8 %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca double, align 8
  %11 = alloca double, align 8
  %12 = alloca double, align 8
  %13 = alloca double, align 8
  %14 = alloca ptr, align 8
  %15 = alloca ptr, align 8
  %16 = alloca ptr, align 8
  %17 = alloca i32, align 4
  %18 = alloca double, align 8
  %19 = alloca double, align 8
  %20 = alloca double, align 8
  %21 = alloca i32, align 4
  %22 = alloca double, align 8
  %23 = alloca double, align 8
  %24 = alloca double, align 8
  %25 = alloca double, align 8
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  store i32 %1, ptr %5, align 4, !tbaa !5
  store i32 %2, ptr %6, align 4, !tbaa !5
  store i32 %3, ptr %7, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 8, ptr %8) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %9) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %10) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %11) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %12) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %13) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %14) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %15) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %16) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %17) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %18) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %19) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %20) #11
  %32 = load i32, ptr %7, align 4, !tbaa !5
  %33 = sitofp i32 %32 to double
  %34 = fmul double 1.230000e+02, %33
  store double %34, ptr %20, align 8, !tbaa !21
  call void @llvm.lifetime.start.p0(i64 4, ptr %21) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %22) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %23) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %24) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %25) #11
  store double 0x3FE2D97C7F3321D2, ptr %8, align 8, !tbaa !21
  %35 = load double, ptr %8, align 8, !tbaa !21
  %36 = fdiv double 1.000000e+00, %35
  %37 = call double @sqrt(double noundef %36) #11, !tbaa !5
  store double %37, ptr %9, align 8, !tbaa !21
  call void @llvm.lifetime.start.p0(i64 4, ptr %26) #11
  store i32 0, ptr %26, align 4, !tbaa !5
  br label %38

38:                                               ; preds = %46, %4
  %39 = load i32, ptr %26, align 4, !tbaa !5
  %40 = icmp slt i32 %39, 3
  br i1 %40, label %41, label %49

41:                                               ; preds = %38
  %42 = getelementptr inbounds nuw %struct.datapoints, ptr %0, i32 0, i32 0
  %43 = load i32, ptr %26, align 4, !tbaa !5
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [3 x double], ptr %42, i64 0, i64 %44
  store double 0.000000e+00, ptr %45, align 8, !tbaa !21
  br label %46

46:                                               ; preds = %41
  %47 = load i32, ptr %26, align 4, !tbaa !5
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %26, align 4, !tbaa !5
  br label %38, !llvm.loop !49

49:                                               ; preds = %38
  call void @llvm.lifetime.end.p0(i64 4, ptr %26) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %27) #11
  store i32 0, ptr %27, align 4, !tbaa !5
  br label %50

50:                                               ; preds = %58, %49
  %51 = load i32, ptr %27, align 4, !tbaa !5
  %52 = icmp slt i32 %51, 3
  br i1 %52, label %53, label %61

53:                                               ; preds = %50
  %54 = getelementptr inbounds nuw %struct.datapoints, ptr %0, i32 0, i32 1
  %55 = load i32, ptr %27, align 4, !tbaa !5
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds [3 x double], ptr %54, i64 0, i64 %56
  store double 0.000000e+00, ptr %57, align 8, !tbaa !21
  br label %58

58:                                               ; preds = %53
  %59 = load i32, ptr %27, align 4, !tbaa !5
  %60 = add nsw i32 %59, 1
  store i32 %60, ptr %27, align 4, !tbaa !5
  br label %50, !llvm.loop !50

61:                                               ; preds = %50
  call void @llvm.lifetime.end.p0(i64 4, ptr %27) #11
  %62 = load i32, ptr %5, align 4, !tbaa !5
  %63 = call ptr @ubody_alloc(i32 noundef %62)
  store ptr %63, ptr %14, align 8, !tbaa !15
  %64 = load ptr, ptr %14, align 8, !tbaa !15
  store ptr %64, ptr %16, align 8, !tbaa !15
  store i32 0, ptr %17, align 4, !tbaa !5
  br label %65

65:                                               ; preds = %268, %61
  %66 = load i32, ptr %17, align 4, !tbaa !5
  %67 = load i32, ptr %6, align 4, !tbaa !5
  %68 = icmp slt i32 %66, %67
  br i1 %68, label %69, label %271

69:                                               ; preds = %65
  %70 = load i32, ptr %5, align 4, !tbaa !5
  %71 = call ptr @ubody_alloc(i32 noundef %70)
  store ptr %71, ptr %15, align 8, !tbaa !15
  %72 = load ptr, ptr %15, align 8, !tbaa !15
  %73 = icmp eq ptr %72, null
  br i1 %73, label %74, label %76

74:                                               ; preds = %69
  %75 = call i32 (ptr, ...) @error(ptr noundef @.str.4)
  br label %76

76:                                               ; preds = %74, %69
  %77 = load ptr, ptr %15, align 8, !tbaa !15
  %78 = load ptr, ptr %16, align 8, !tbaa !15
  %rds.field.ptr = getelementptr inbounds %struct.bnode, ptr %78, i32 0, i32 10
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %79 = getelementptr inbounds nuw %struct.bnode, ptr %78, i32 0, i32 9
  store ptr %77, ptr %79, align 8, !tbaa !30
  %80 = load ptr, ptr %15, align 8, !tbaa !15
  store ptr %80, ptr %16, align 8, !tbaa !15
  %81 = load ptr, ptr %15, align 8, !tbaa !15
  %82 = getelementptr inbounds nuw %struct.bnode, ptr %81, i32 0, i32 0
  store i16 1, ptr %82, align 8, !tbaa !51
  %83 = load i32, ptr %6, align 4, !tbaa !5
  %84 = sitofp i32 %83 to double
  %85 = fdiv double 1.000000e+00, %84
  %86 = load ptr, ptr %15, align 8, !tbaa !15
  %87 = getelementptr inbounds nuw %struct.bnode, ptr %86, i32 0, i32 1
  store double %85, ptr %87, align 8, !tbaa !52
  %88 = load double, ptr %20, align 8, !tbaa !21
  %89 = call double (double, ...) @my_rand(double noundef %88)
  store double %89, ptr %20, align 8, !tbaa !21
  %90 = load double, ptr %20, align 8, !tbaa !21
  %91 = call double (double, double, double, ...) @xrand(double noundef 0.000000e+00, double noundef 0x3FEFF7CED916872B, double noundef %90)
  store double %91, ptr %19, align 8, !tbaa !21
  %92 = load double, ptr %19, align 8, !tbaa !21
  %93 = call double @pow(double noundef %92, double noundef 0xBFE5555555555555) #11, !tbaa !5
  %94 = fsub double %93, 1.000000e+00
  store double %94, ptr %18, align 8, !tbaa !21
  %95 = load double, ptr %18, align 8, !tbaa !21
  %96 = call double @sqrt(double noundef %95) #11, !tbaa !5
  %97 = fdiv double 1.000000e+00, %96
  store double %97, ptr %10, align 8, !tbaa !21
  store double 4.000000e+00, ptr %25, align 8, !tbaa !21
  store i32 0, ptr %21, align 4, !tbaa !5
  br label %98

98:                                               ; preds = %114, %76
  %99 = load i32, ptr %21, align 4, !tbaa !5
  %100 = icmp slt i32 %99, 3
  br i1 %100, label %101, label %117

101:                                              ; preds = %98
  %102 = load double, ptr %20, align 8, !tbaa !21
  %103 = call double (double, ...) @my_rand(double noundef %102)
  store double %103, ptr %20, align 8, !tbaa !21
  %104 = load double, ptr %20, align 8, !tbaa !21
  %105 = call double (double, double, double, ...) @xrand(double noundef 0.000000e+00, double noundef 0x3FEFF7CED916872B, double noundef %104)
  store double %105, ptr %10, align 8, !tbaa !21
  %106 = load double, ptr %25, align 8, !tbaa !21
  %107 = load double, ptr %10, align 8, !tbaa !21
  %108 = fmul double %106, %107
  %109 = load ptr, ptr %15, align 8, !tbaa !15
  %rds.field.ptr21 = getelementptr inbounds %struct.bnode, ptr %109, i32 0, i32 9
  %rds.field.val22 = load ptr, ptr %rds.field.ptr21, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val22, i32 0, i32 3, i32 1)
  %rds.field.ptr23 = getelementptr inbounds %struct.bnode, ptr %109, i32 0, i32 10
  %rds.field.val24 = load ptr, ptr %rds.field.ptr23, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val24, i32 0, i32 3, i32 1)
  %110 = getelementptr inbounds nuw %struct.bnode, ptr %109, i32 0, i32 2
  %111 = load i32, ptr %21, align 4, !tbaa !5
  %112 = sext i32 %111 to i64
  %113 = getelementptr inbounds [3 x double], ptr %110, i64 0, i64 %112
  store double %108, ptr %113, align 8, !tbaa !21
  br label %114

114:                                              ; preds = %101
  %115 = load i32, ptr %21, align 4, !tbaa !5
  %116 = add nsw i32 %115, 1
  store i32 %116, ptr %21, align 4, !tbaa !5
  br label %98, !llvm.loop !53

117:                                              ; preds = %98
  call void @llvm.lifetime.start.p0(i64 4, ptr %28) #11
  store i32 0, ptr %28, align 4, !tbaa !5
  br label %118

118:                                              ; preds = %138, %117
  %119 = load i32, ptr %28, align 4, !tbaa !5
  %120 = icmp slt i32 %119, 3
  br i1 %120, label %121, label %141

121:                                              ; preds = %118
  %122 = getelementptr inbounds nuw %struct.datapoints, ptr %0, i32 0, i32 0
  %123 = load i32, ptr %28, align 4, !tbaa !5
  %124 = sext i32 %123 to i64
  %125 = getelementptr inbounds [3 x double], ptr %122, i64 0, i64 %124
  %126 = load double, ptr %125, align 8, !tbaa !21
  %127 = load ptr, ptr %15, align 8, !tbaa !15
  %rds.field.ptr17 = getelementptr inbounds %struct.bnode, ptr %127, i32 0, i32 9
  %rds.field.val18 = load ptr, ptr %rds.field.ptr17, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val18, i32 0, i32 3, i32 1)
  %rds.field.ptr19 = getelementptr inbounds %struct.bnode, ptr %127, i32 0, i32 10
  %rds.field.val20 = load ptr, ptr %rds.field.ptr19, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val20, i32 0, i32 3, i32 1)
  %128 = getelementptr inbounds nuw %struct.bnode, ptr %127, i32 0, i32 2
  %129 = load i32, ptr %28, align 4, !tbaa !5
  %130 = sext i32 %129 to i64
  %131 = getelementptr inbounds [3 x double], ptr %128, i64 0, i64 %130
  %132 = load double, ptr %131, align 8, !tbaa !21
  %133 = fadd double %126, %132
  %134 = getelementptr inbounds nuw %struct.datapoints, ptr %0, i32 0, i32 0
  %135 = load i32, ptr %28, align 4, !tbaa !5
  %136 = sext i32 %135 to i64
  %137 = getelementptr inbounds [3 x double], ptr %134, i64 0, i64 %136
  store double %133, ptr %137, align 8, !tbaa !21
  br label %138

138:                                              ; preds = %121
  %139 = load i32, ptr %28, align 4, !tbaa !5
  %140 = add nsw i32 %139, 1
  store i32 %140, ptr %28, align 4, !tbaa !5
  br label %118, !llvm.loop !54

141:                                              ; preds = %118
  call void @llvm.lifetime.end.p0(i64 4, ptr %28) #11
  br label %142

142:                                              ; preds = %151, %141
  %143 = load double, ptr %20, align 8, !tbaa !21
  %144 = call double (double, ...) @my_rand(double noundef %143)
  store double %144, ptr %20, align 8, !tbaa !21
  %145 = load double, ptr %20, align 8, !tbaa !21
  %146 = call double (double, double, double, ...) @xrand(double noundef 0.000000e+00, double noundef 1.000000e+00, double noundef %145)
  store double %146, ptr %12, align 8, !tbaa !21
  %147 = load double, ptr %20, align 8, !tbaa !21
  %148 = call double (double, ...) @my_rand(double noundef %147)
  store double %148, ptr %20, align 8, !tbaa !21
  %149 = load double, ptr %20, align 8, !tbaa !21
  %150 = call double (double, double, double, ...) @xrand(double noundef 0.000000e+00, double noundef 1.000000e-01, double noundef %149)
  store double %150, ptr %13, align 8, !tbaa !21
  br label %151

151:                                              ; preds = %142
  %152 = load double, ptr %13, align 8, !tbaa !21
  %153 = load double, ptr %12, align 8, !tbaa !21
  %154 = load double, ptr %12, align 8, !tbaa !21
  %155 = fmul double %153, %154
  %156 = load double, ptr %12, align 8, !tbaa !21
  %157 = load double, ptr %12, align 8, !tbaa !21
  %158 = fneg double %156
  %159 = call double @llvm.fmuladd.f64(double %158, double %157, double 1.000000e+00)
  %160 = call double @pow(double noundef %159, double noundef 3.500000e+00) #11, !tbaa !5
  %161 = fmul double %155, %160
  %162 = fcmp ogt double %152, %161
  br i1 %162, label %142, label %163, !llvm.loop !55

163:                                              ; preds = %151
  %164 = call double @sqrt(double noundef 2.000000e+00) #11, !tbaa !5
  %165 = load double, ptr %12, align 8, !tbaa !21
  %166 = fmul double %164, %165
  %167 = load double, ptr %10, align 8, !tbaa !21
  %168 = load double, ptr %10, align 8, !tbaa !21
  %169 = call double @llvm.fmuladd.f64(double %167, double %168, double 1.000000e+00)
  %170 = call double @pow(double noundef %169, double noundef 2.500000e-01) #11, !tbaa !5
  %171 = fdiv double %166, %170
  store double %171, ptr %11, align 8, !tbaa !21
  %172 = load double, ptr %9, align 8, !tbaa !21
  %173 = load double, ptr %11, align 8, !tbaa !21
  %174 = fmul double %172, %173
  store double %174, ptr %24, align 8, !tbaa !21
  br label %175

175:                                              ; preds = %215, %163
  store i32 0, ptr %21, align 4, !tbaa !5
  br label %176

176:                                              ; preds = %189, %175
  %177 = load i32, ptr %21, align 4, !tbaa !5
  %178 = icmp slt i32 %177, 3
  br i1 %178, label %179, label %192

179:                                              ; preds = %176
  %180 = load double, ptr %20, align 8, !tbaa !21
  %181 = call double (double, ...) @my_rand(double noundef %180)
  store double %181, ptr %20, align 8, !tbaa !21
  %182 = load double, ptr %20, align 8, !tbaa !21
  %183 = call double (double, double, double, ...) @xrand(double noundef -1.000000e+00, double noundef 1.000000e+00, double noundef %182)
  %184 = load ptr, ptr %15, align 8, !tbaa !15
  %rds.field.ptr13 = getelementptr inbounds %struct.bnode, ptr %184, i32 0, i32 9
  %rds.field.val14 = load ptr, ptr %rds.field.ptr13, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val14, i32 0, i32 3, i32 1)
  %rds.field.ptr15 = getelementptr inbounds %struct.bnode, ptr %184, i32 0, i32 10
  %rds.field.val16 = load ptr, ptr %rds.field.ptr15, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val16, i32 0, i32 3, i32 1)
  %185 = getelementptr inbounds nuw %struct.bnode, ptr %184, i32 0, i32 5
  %186 = load i32, ptr %21, align 4, !tbaa !5
  %187 = sext i32 %186 to i64
  %188 = getelementptr inbounds [3 x double], ptr %185, i64 0, i64 %187
  store double %183, ptr %188, align 8, !tbaa !21
  br label %189

189:                                              ; preds = %179
  %190 = load i32, ptr %21, align 4, !tbaa !5
  %191 = add nsw i32 %190, 1
  store i32 %191, ptr %21, align 4, !tbaa !5
  br label %176, !llvm.loop !56

192:                                              ; preds = %176
  call void @llvm.lifetime.start.p0(i64 4, ptr %29) #11
  store double 0.000000e+00, ptr %22, align 8, !tbaa !21
  store i32 0, ptr %29, align 4, !tbaa !5
  br label %193

193:                                              ; preds = %211, %192
  %194 = load i32, ptr %29, align 4, !tbaa !5
  %195 = icmp slt i32 %194, 3
  br i1 %195, label %196, label %214

196:                                              ; preds = %193
  %197 = load ptr, ptr %15, align 8, !tbaa !15
  %rds.field.ptr9 = getelementptr inbounds %struct.bnode, ptr %197, i32 0, i32 9
  %rds.field.val10 = load ptr, ptr %rds.field.ptr9, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val10, i32 0, i32 3, i32 1)
  %rds.field.ptr11 = getelementptr inbounds %struct.bnode, ptr %197, i32 0, i32 10
  %rds.field.val12 = load ptr, ptr %rds.field.ptr11, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val12, i32 0, i32 3, i32 1)
  %198 = getelementptr inbounds nuw %struct.bnode, ptr %197, i32 0, i32 5
  %199 = load i32, ptr %29, align 4, !tbaa !5
  %200 = sext i32 %199 to i64
  %201 = getelementptr inbounds [3 x double], ptr %198, i64 0, i64 %200
  %202 = load double, ptr %201, align 8, !tbaa !21
  %203 = load ptr, ptr %15, align 8, !tbaa !15
  %204 = getelementptr inbounds nuw %struct.bnode, ptr %203, i32 0, i32 5
  %205 = load i32, ptr %29, align 4, !tbaa !5
  %206 = sext i32 %205 to i64
  %207 = getelementptr inbounds [3 x double], ptr %204, i64 0, i64 %206
  %208 = load double, ptr %207, align 8, !tbaa !21
  %209 = load double, ptr %22, align 8, !tbaa !21
  %210 = call double @llvm.fmuladd.f64(double %202, double %208, double %209)
  store double %210, ptr %22, align 8, !tbaa !21
  br label %211

211:                                              ; preds = %196
  %212 = load i32, ptr %29, align 4, !tbaa !5
  %213 = add nsw i32 %212, 1
  store i32 %213, ptr %29, align 4, !tbaa !5
  br label %193, !llvm.loop !57

214:                                              ; preds = %193
  call void @llvm.lifetime.end.p0(i64 4, ptr %29) #11
  br label %215

215:                                              ; preds = %214
  %216 = load double, ptr %22, align 8, !tbaa !21
  %217 = fcmp ogt double %216, 1.000000e+00
  br i1 %217, label %175, label %218, !llvm.loop !58

218:                                              ; preds = %215
  %219 = load double, ptr %24, align 8, !tbaa !21
  %220 = load double, ptr %22, align 8, !tbaa !21
  %221 = call double @sqrt(double noundef %220) #11, !tbaa !5
  %222 = fdiv double %219, %221
  store double %222, ptr %23, align 8, !tbaa !21
  call void @llvm.lifetime.start.p0(i64 4, ptr %30) #11
  store i32 0, ptr %30, align 4, !tbaa !5
  br label %223

223:                                              ; preds = %240, %218
  %224 = load i32, ptr %30, align 4, !tbaa !5
  %225 = icmp slt i32 %224, 3
  br i1 %225, label %226, label %243

226:                                              ; preds = %223
  %227 = load ptr, ptr %15, align 8, !tbaa !15
  %rds.field.ptr5 = getelementptr inbounds %struct.bnode, ptr %227, i32 0, i32 9
  %rds.field.val6 = load ptr, ptr %rds.field.ptr5, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val6, i32 0, i32 3, i32 1)
  %rds.field.ptr7 = getelementptr inbounds %struct.bnode, ptr %227, i32 0, i32 10
  %rds.field.val8 = load ptr, ptr %rds.field.ptr7, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val8, i32 0, i32 3, i32 1)
  %228 = getelementptr inbounds nuw %struct.bnode, ptr %227, i32 0, i32 5
  %229 = load i32, ptr %30, align 4, !tbaa !5
  %230 = sext i32 %229 to i64
  %231 = getelementptr inbounds [3 x double], ptr %228, i64 0, i64 %230
  %232 = load double, ptr %231, align 8, !tbaa !21
  %233 = load double, ptr %23, align 8, !tbaa !21
  %234 = fmul double %232, %233
  %235 = load ptr, ptr %15, align 8, !tbaa !15
  %236 = getelementptr inbounds nuw %struct.bnode, ptr %235, i32 0, i32 5
  %237 = load i32, ptr %30, align 4, !tbaa !5
  %238 = sext i32 %237 to i64
  %239 = getelementptr inbounds [3 x double], ptr %236, i64 0, i64 %238
  store double %234, ptr %239, align 8, !tbaa !21
  br label %240

240:                                              ; preds = %226
  %241 = load i32, ptr %30, align 4, !tbaa !5
  %242 = add nsw i32 %241, 1
  store i32 %242, ptr %30, align 4, !tbaa !5
  br label %223, !llvm.loop !59

243:                                              ; preds = %223
  call void @llvm.lifetime.end.p0(i64 4, ptr %30) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %31) #11
  store i32 0, ptr %31, align 4, !tbaa !5
  br label %244

244:                                              ; preds = %264, %243
  %245 = load i32, ptr %31, align 4, !tbaa !5
  %246 = icmp slt i32 %245, 3
  br i1 %246, label %247, label %267

247:                                              ; preds = %244
  %248 = getelementptr inbounds nuw %struct.datapoints, ptr %0, i32 0, i32 1
  %249 = load i32, ptr %31, align 4, !tbaa !5
  %250 = sext i32 %249 to i64
  %251 = getelementptr inbounds [3 x double], ptr %248, i64 0, i64 %250
  %252 = load double, ptr %251, align 8, !tbaa !21
  %253 = load ptr, ptr %15, align 8, !tbaa !15
  %rds.field.ptr1 = getelementptr inbounds %struct.bnode, ptr %253, i32 0, i32 9
  %rds.field.val2 = load ptr, ptr %rds.field.ptr1, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val2, i32 0, i32 3, i32 1)
  %rds.field.ptr3 = getelementptr inbounds %struct.bnode, ptr %253, i32 0, i32 10
  %rds.field.val4 = load ptr, ptr %rds.field.ptr3, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val4, i32 0, i32 3, i32 1)
  %254 = getelementptr inbounds nuw %struct.bnode, ptr %253, i32 0, i32 5
  %255 = load i32, ptr %31, align 4, !tbaa !5
  %256 = sext i32 %255 to i64
  %257 = getelementptr inbounds [3 x double], ptr %254, i64 0, i64 %256
  %258 = load double, ptr %257, align 8, !tbaa !21
  %259 = fadd double %252, %258
  %260 = getelementptr inbounds nuw %struct.datapoints, ptr %0, i32 0, i32 1
  %261 = load i32, ptr %31, align 4, !tbaa !5
  %262 = sext i32 %261 to i64
  %263 = getelementptr inbounds [3 x double], ptr %260, i64 0, i64 %262
  store double %259, ptr %263, align 8, !tbaa !21
  br label %264

264:                                              ; preds = %247
  %265 = load i32, ptr %31, align 4, !tbaa !5
  %266 = add nsw i32 %265, 1
  store i32 %266, ptr %31, align 4, !tbaa !5
  br label %244, !llvm.loop !60

267:                                              ; preds = %244
  call void @llvm.lifetime.end.p0(i64 4, ptr %31) #11
  br label %268

268:                                              ; preds = %267
  %269 = load i32, ptr %17, align 4, !tbaa !5
  %270 = add nsw i32 %269, 1
  store i32 %270, ptr %17, align 4, !tbaa !5
  br label %65, !llvm.loop !61

271:                                              ; preds = %65
  %272 = load ptr, ptr %16, align 8, !tbaa !15
  %273 = getelementptr inbounds nuw %struct.bnode, ptr %272, i32 0, i32 9
  store ptr null, ptr %273, align 8, !tbaa !30
  %274 = load ptr, ptr %14, align 8, !tbaa !15
  %275 = getelementptr inbounds nuw %struct.bnode, ptr %274, i32 0, i32 9
  %276 = load ptr, ptr %275, align 8, !tbaa !30
  %277 = getelementptr inbounds nuw %struct.datapoints, ptr %0, i32 0, i32 2
  store ptr %276, ptr %277, align 8, !tbaa !28
  %278 = load ptr, ptr %16, align 8, !tbaa !15
  %279 = getelementptr inbounds nuw %struct.datapoints, ptr %0, i32 0, i32 3
  store ptr %278, ptr %279, align 8, !tbaa !33
  call void @llvm.lifetime.end.p0(i64 8, ptr %25) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %24) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %23) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %22) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %21) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %20) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %19) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %18) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %17) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %16) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %15) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %14) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %13) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %12) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %11) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %10) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %9) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %8) #11
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #6

; Function Attrs: nounwind uwtable
define dso_local { i64, i64 } @intcoord(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca %struct.icstruct, align 4
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca double, align 8
  %7 = alloca double, align 8
  %8 = alloca [3 x double], align 16
  store ptr %0, ptr %4, align 8, !tbaa !15
  store ptr %1, ptr %5, align 8, !tbaa !14
  call void @llvm.lifetime.start.p0(i64 8, ptr %6) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %7) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %8) #11
  %9 = getelementptr inbounds nuw %struct.icstruct, ptr %3, i32 0, i32 1
  store i16 1, ptr %9, align 4, !tbaa !62
  %10 = load ptr, ptr %5, align 8, !tbaa !14
  %11 = getelementptr inbounds nuw %struct.tree, ptr %10, i32 0, i32 1
  %12 = load double, ptr %11, align 8, !tbaa !22
  store double %12, ptr %7, align 8, !tbaa !21
  %13 = load ptr, ptr %4, align 8, !tbaa !15
  %14 = getelementptr inbounds nuw %struct.bnode, ptr %13, i32 0, i32 2
  %15 = getelementptr inbounds [3 x double], ptr %14, i64 0, i64 0
  %16 = load double, ptr %15, align 8, !tbaa !21
  %17 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 0
  store double %16, ptr %17, align 16, !tbaa !21
  %18 = load ptr, ptr %4, align 8, !tbaa !15
  %19 = getelementptr inbounds nuw %struct.bnode, ptr %18, i32 0, i32 2
  %20 = getelementptr inbounds [3 x double], ptr %19, i64 0, i64 1
  %21 = load double, ptr %20, align 8, !tbaa !21
  %22 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 1
  store double %21, ptr %22, align 8, !tbaa !21
  %23 = load ptr, ptr %4, align 8, !tbaa !15
  %24 = getelementptr inbounds nuw %struct.bnode, ptr %23, i32 0, i32 2
  %25 = getelementptr inbounds [3 x double], ptr %24, i64 0, i64 2
  %26 = load double, ptr %25, align 8, !tbaa !21
  %27 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 2
  store double %26, ptr %27, align 16, !tbaa !21
  %28 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 0
  %29 = load double, ptr %28, align 16, !tbaa !21
  %30 = load ptr, ptr %5, align 8, !tbaa !14
  %31 = getelementptr inbounds nuw %struct.tree, ptr %30, i32 0, i32 0
  %32 = getelementptr inbounds [3 x double], ptr %31, i64 0, i64 0
  %33 = load double, ptr %32, align 8, !tbaa !21
  %34 = fsub double %29, %33
  %35 = load double, ptr %7, align 8, !tbaa !21
  %36 = fdiv double %34, %35
  store double %36, ptr %6, align 8, !tbaa !21
  %37 = load double, ptr %6, align 8, !tbaa !21
  %38 = fcmp ole double 0.000000e+00, %37
  br i1 %38, label %39, label %49

39:                                               ; preds = %2
  %40 = load double, ptr %6, align 8, !tbaa !21
  %41 = fcmp olt double %40, 1.000000e+00
  br i1 %41, label %42, label %49

42:                                               ; preds = %39
  %43 = load double, ptr %6, align 8, !tbaa !21
  %44 = fmul double 0x41D0000000000000, %43
  %45 = call double @llvm.floor.f64(double %44)
  %46 = fptosi double %45 to i32
  %47 = getelementptr inbounds nuw %struct.icstruct, ptr %3, i32 0, i32 0
  %48 = getelementptr inbounds [3 x i32], ptr %47, i64 0, i64 0
  store i32 %46, ptr %48, align 4, !tbaa !5
  br label %53

49:                                               ; preds = %39, %2
  %50 = getelementptr inbounds nuw %struct.icstruct, ptr %3, i32 0, i32 1
  store i16 0, ptr %50, align 4, !tbaa !62
  %51 = getelementptr inbounds nuw %struct.icstruct, ptr %3, i32 0, i32 0
  %52 = getelementptr inbounds [3 x i32], ptr %51, i64 0, i64 0
  store i32 0, ptr %52, align 4, !tbaa !5
  br label %53

53:                                               ; preds = %49, %42
  %54 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 1
  %55 = load double, ptr %54, align 8, !tbaa !21
  %56 = load ptr, ptr %5, align 8, !tbaa !14
  %57 = getelementptr inbounds nuw %struct.tree, ptr %56, i32 0, i32 0
  %58 = getelementptr inbounds [3 x double], ptr %57, i64 0, i64 1
  %59 = load double, ptr %58, align 8, !tbaa !21
  %60 = fsub double %55, %59
  %61 = load double, ptr %7, align 8, !tbaa !21
  %62 = fdiv double %60, %61
  store double %62, ptr %6, align 8, !tbaa !21
  %63 = load double, ptr %6, align 8, !tbaa !21
  %64 = fcmp ole double 0.000000e+00, %63
  br i1 %64, label %65, label %75

65:                                               ; preds = %53
  %66 = load double, ptr %6, align 8, !tbaa !21
  %67 = fcmp olt double %66, 1.000000e+00
  br i1 %67, label %68, label %75

68:                                               ; preds = %65
  %69 = load double, ptr %6, align 8, !tbaa !21
  %70 = fmul double 0x41D0000000000000, %69
  %71 = call double @llvm.floor.f64(double %70)
  %72 = fptosi double %71 to i32
  %73 = getelementptr inbounds nuw %struct.icstruct, ptr %3, i32 0, i32 0
  %74 = getelementptr inbounds [3 x i32], ptr %73, i64 0, i64 1
  store i32 %72, ptr %74, align 4, !tbaa !5
  br label %79

75:                                               ; preds = %65, %53
  %76 = getelementptr inbounds nuw %struct.icstruct, ptr %3, i32 0, i32 1
  store i16 0, ptr %76, align 4, !tbaa !62
  %77 = getelementptr inbounds nuw %struct.icstruct, ptr %3, i32 0, i32 0
  %78 = getelementptr inbounds [3 x i32], ptr %77, i64 0, i64 1
  store i32 0, ptr %78, align 4, !tbaa !5
  br label %79

79:                                               ; preds = %75, %68
  %80 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 2
  %81 = load double, ptr %80, align 16, !tbaa !21
  %82 = load ptr, ptr %5, align 8, !tbaa !14
  %83 = getelementptr inbounds nuw %struct.tree, ptr %82, i32 0, i32 0
  %84 = getelementptr inbounds [3 x double], ptr %83, i64 0, i64 2
  %85 = load double, ptr %84, align 8, !tbaa !21
  %86 = fsub double %81, %85
  %87 = load double, ptr %7, align 8, !tbaa !21
  %88 = fdiv double %86, %87
  store double %88, ptr %6, align 8, !tbaa !21
  %89 = load double, ptr %6, align 8, !tbaa !21
  %90 = fcmp ole double 0.000000e+00, %89
  br i1 %90, label %91, label %101

91:                                               ; preds = %79
  %92 = load double, ptr %6, align 8, !tbaa !21
  %93 = fcmp olt double %92, 1.000000e+00
  br i1 %93, label %94, label %101

94:                                               ; preds = %91
  %95 = load double, ptr %6, align 8, !tbaa !21
  %96 = fmul double 0x41D0000000000000, %95
  %97 = call double @llvm.floor.f64(double %96)
  %98 = fptosi double %97 to i32
  %99 = getelementptr inbounds nuw %struct.icstruct, ptr %3, i32 0, i32 0
  %100 = getelementptr inbounds [3 x i32], ptr %99, i64 0, i64 2
  store i32 %98, ptr %100, align 4, !tbaa !5
  br label %105

101:                                              ; preds = %91, %79
  %102 = getelementptr inbounds nuw %struct.icstruct, ptr %3, i32 0, i32 1
  store i16 0, ptr %102, align 4, !tbaa !62
  %103 = getelementptr inbounds nuw %struct.icstruct, ptr %3, i32 0, i32 0
  %104 = getelementptr inbounds [3 x i32], ptr %103, i64 0, i64 2
  store i32 0, ptr %104, align 4, !tbaa !5
  br label %105

105:                                              ; preds = %101, %94
  call void @llvm.lifetime.end.p0(i64 24, ptr %8) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %7) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %6) #11
  %106 = load { i64, i64 }, ptr %3, align 4
  ret { i64, i64 } %106
}

; Function Attrs: nounwind uwtable
define dso_local i32 @old_subindex(i64 %0, i64 %1, i32 noundef %2) #0 {
  %4 = alloca %struct.icstruct, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = getelementptr inbounds nuw { i64, i64 }, ptr %4, i32 0, i32 0
  store i64 %0, ptr %8, align 4
  %9 = getelementptr inbounds nuw { i64, i64 }, ptr %4, i32 0, i32 1
  store i64 %1, ptr %9, align 4
  store i32 %2, ptr %5, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 4, ptr %6) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %7) #11
  store i32 0, ptr %6, align 4, !tbaa !5
  store i32 0, ptr %7, align 4, !tbaa !5
  br label %10

10:                                               ; preds = %29, %3
  %11 = load i32, ptr %7, align 4, !tbaa !5
  %12 = icmp slt i32 %11, 3
  br i1 %12, label %13, label %32

13:                                               ; preds = %10
  %14 = getelementptr inbounds nuw %struct.icstruct, ptr %4, i32 0, i32 0
  %15 = load i32, ptr %7, align 4, !tbaa !5
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [3 x i32], ptr %14, i64 0, i64 %16
  %18 = load i32, ptr %17, align 4, !tbaa !5
  %19 = load i32, ptr %5, align 4, !tbaa !5
  %20 = and i32 %18, %19
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %22, label %28

22:                                               ; preds = %13
  %23 = load i32, ptr %7, align 4, !tbaa !5
  %24 = add nsw i32 %23, 1
  %25 = ashr i32 8, %24
  %26 = load i32, ptr %6, align 4, !tbaa !5
  %27 = add nsw i32 %26, %25
  store i32 %27, ptr %6, align 4, !tbaa !5
  br label %28

28:                                               ; preds = %22, %13
  br label %29

29:                                               ; preds = %28
  %30 = load i32, ptr %7, align 4, !tbaa !5
  %31 = add nsw i32 %30, 1
  store i32 %31, ptr %7, align 4, !tbaa !5
  br label %10, !llvm.loop !64

32:                                               ; preds = %10
  %33 = load i32, ptr %6, align 4, !tbaa !5
  call void @llvm.lifetime.end.p0(i64 4, ptr %7) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %6) #11
  ret i32 %33
}

; Function Attrs: nounwind uwtable
define dso_local void @stepsystem(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store ptr %0, ptr %3, align 8, !tbaa !14
  store i32 %1, ptr %4, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 8, ptr %5) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %6) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %7) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %8) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %9) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %10) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %11) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %12) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %13) #11
  %14 = load ptr, ptr %3, align 8, !tbaa !14
  %15 = getelementptr inbounds nuw %struct.tree, ptr %14, i32 0, i32 2
  %16 = load ptr, ptr %15, align 8, !tbaa !17
  %17 = icmp ne ptr %16, null
  br i1 %17, label %18, label %24

18:                                               ; preds = %2
  %19 = load ptr, ptr %3, align 8, !tbaa !14
  %20 = getelementptr inbounds nuw %struct.tree, ptr %19, i32 0, i32 2
  %21 = load ptr, ptr %20, align 8, !tbaa !17
  call void @freetree1(ptr noundef %21)
  %22 = load ptr, ptr %3, align 8, !tbaa !14
  %23 = getelementptr inbounds nuw %struct.tree, ptr %22, i32 0, i32 2
  store ptr null, ptr %23, align 8, !tbaa !17
  br label %24

24:                                               ; preds = %18, %2
  %25 = load ptr, ptr %5, align 8, !tbaa !15
  %26 = load i32, ptr @nbody, align 4, !tbaa !5
  %27 = load ptr, ptr %3, align 8, !tbaa !14
  %28 = load i32, ptr %4, align 4, !tbaa !5
  %29 = call ptr @maketree(ptr noundef %25, i32 noundef %26, ptr noundef %27, i32 noundef %28, i32 noundef 0)
  store ptr %29, ptr %9, align 8, !tbaa !65
  %30 = load ptr, ptr %9, align 8, !tbaa !65
  %31 = load ptr, ptr %3, align 8, !tbaa !14
  %32 = getelementptr inbounds nuw %struct.tree, ptr %31, i32 0, i32 2
  store ptr %30, ptr %32, align 8, !tbaa !17
  %33 = load ptr, ptr %3, align 8, !tbaa !14
  %34 = load i32, ptr %4, align 4, !tbaa !5
  call void @computegrav(ptr noundef %33, i32 noundef %34)
  %35 = load ptr, ptr %3, align 8, !tbaa !14
  %36 = getelementptr inbounds nuw %struct.tree, ptr %35, i32 0, i32 4
  %37 = getelementptr inbounds [64 x ptr], ptr %36, i64 0, i64 0
  %38 = load ptr, ptr %37, align 8, !tbaa !15
  %39 = load i32, ptr %4, align 4, !tbaa !5
  call void @vp(ptr noundef %38, i32 noundef %39)
  call void @llvm.lifetime.end.p0(i64 4, ptr %13) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %12) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %11) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %10) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %9) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %8) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %7) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %6) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %5) #11
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @freetree1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 8, !tbaa !65
  call void @llvm.lifetime.start.p0(i64 8, ptr %3) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %4) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #11
  %6 = load ptr, ptr %2, align 8, !tbaa !65
  call void @freetree(ptr noundef %6)
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %4) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %3) #11
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local ptr @maketree(ptr noundef %0, i32 noundef %1, ptr noundef %2, i32 noundef %3, i32 noundef %4) #0 {
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  %13 = alloca ptr, align 8
  %14 = alloca %struct.icstruct, align 4
  %15 = alloca i32, align 4
  %16 = alloca %struct.icstruct, align 4
  store ptr %0, ptr %6, align 8, !tbaa !15
  store i32 %1, ptr %7, align 4, !tbaa !5
  store ptr %2, ptr %8, align 8, !tbaa !14
  store i32 %3, ptr %9, align 4, !tbaa !5
  store i32 %4, ptr %10, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 8, ptr %11) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %12) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %13) #11
  call void @llvm.lifetime.start.p0(i64 16, ptr %14) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %15) #11
  %17 = load ptr, ptr %8, align 8, !tbaa !14
  %18 = getelementptr inbounds nuw %struct.tree, ptr %17, i32 0, i32 2
  store ptr null, ptr %18, align 8, !tbaa !17
  %19 = load i32, ptr %7, align 4, !tbaa !5
  store i32 %19, ptr @nbody, align 4, !tbaa !5
  %20 = load i32, ptr @NumNodes, align 4, !tbaa !5
  %21 = sub nsw i32 %20, 1
  store i32 %21, ptr %12, align 4, !tbaa !5
  br label %22

22:                                               ; preds = %73, %5
  %23 = load i32, ptr %12, align 4, !tbaa !5
  %24 = icmp sge i32 %23, 0
  br i1 %24, label %25, label %76

25:                                               ; preds = %22
  %26 = load ptr, ptr %8, align 8, !tbaa !14
  %rds.field.ptr = getelementptr inbounds %struct.tree, ptr %26, i32 0, i32 2
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %rds.field.ptr1 = getelementptr inbounds %struct.tree, ptr %26, i32 0, i32 3
  %rds.field.val2 = load ptr, ptr %rds.field.ptr1, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val2, i32 0, i32 3, i32 1)
  %27 = getelementptr inbounds nuw %struct.tree, ptr %26, i32 0, i32 4
  %28 = load i32, ptr %12, align 4, !tbaa !5
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [64 x ptr], ptr %27, i64 0, i64 %29
  %31 = load ptr, ptr %30, align 8, !tbaa !15
  store ptr %31, ptr %6, align 8, !tbaa !15
  %32 = load ptr, ptr %6, align 8, !tbaa !15
  store ptr %32, ptr %11, align 8, !tbaa !15
  br label %33

33:                                               ; preds = %68, %25
  %34 = load ptr, ptr %11, align 8, !tbaa !15
  %35 = icmp ne ptr %34, null
  br i1 %35, label %36, label %72

36:                                               ; preds = %33
  %37 = load ptr, ptr %11, align 8, !tbaa !15
  %rds.field.ptr3 = getelementptr inbounds %struct.bnode, ptr %37, i32 0, i32 9
  %rds.field.val4 = load ptr, ptr %rds.field.ptr3, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val4, i32 0, i32 3, i32 1)
  %rds.field.ptr5 = getelementptr inbounds %struct.bnode, ptr %37, i32 0, i32 10
  %rds.field.val6 = load ptr, ptr %rds.field.ptr5, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val6, i32 0, i32 3, i32 1)
  %38 = getelementptr inbounds nuw %struct.bnode, ptr %37, i32 0, i32 1
  %39 = load double, ptr %38, align 8, !tbaa !52
  %40 = fcmp une double %39, 0.000000e+00
  br i1 %40, label %41, label %67

41:                                               ; preds = %36
  %42 = load ptr, ptr %11, align 8, !tbaa !15
  %43 = load ptr, ptr %8, align 8, !tbaa !14
  %44 = load i32, ptr %9, align 4, !tbaa !5
  %45 = load i32, ptr %10, align 4, !tbaa !5
  call void @expandbox(ptr noundef %42, ptr noundef %43, i32 noundef %44, i32 noundef %45)
  call void @llvm.lifetime.start.p0(i64 16, ptr %16) #11
  %46 = load ptr, ptr %11, align 8, !tbaa !15
  %47 = load ptr, ptr %8, align 8, !tbaa !14
  %48 = call { i64, i64 } @intcoord(ptr noundef %46, ptr noundef %47)
  %49 = getelementptr inbounds nuw { i64, i64 }, ptr %16, i32 0, i32 0
  %50 = extractvalue { i64, i64 } %48, 0
  store i64 %50, ptr %49, align 4
  %51 = getelementptr inbounds nuw { i64, i64 }, ptr %16, i32 0, i32 1
  %52 = extractvalue { i64, i64 } %48, 1
  store i64 %52, ptr %51, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %14, ptr align 4 %16, i64 16, i1 false), !tbaa.struct !42
  call void @llvm.lifetime.end.p0(i64 16, ptr %16) #11
  %53 = load ptr, ptr %8, align 8, !tbaa !14
  %rds.field.ptr7 = getelementptr inbounds %struct.tree, ptr %53, i32 0, i32 3
  %rds.field.val8 = load ptr, ptr %rds.field.ptr7, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val8, i32 0, i32 3, i32 1)
  %rds.field.ptr9 = getelementptr inbounds %struct.tree, ptr %53, i32 0, i32 4
  %rds.field.val10 = load ptr, ptr %rds.field.ptr9, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val10, i32 0, i32 3, i32 1)
  %54 = getelementptr inbounds nuw %struct.tree, ptr %53, i32 0, i32 2
  %55 = load ptr, ptr %54, align 8, !tbaa !17
  store ptr %55, ptr %13, align 8, !tbaa !65
  %56 = load ptr, ptr %11, align 8, !tbaa !15
  %57 = load ptr, ptr %13, align 8, !tbaa !65
  %58 = load ptr, ptr %8, align 8, !tbaa !14
  %59 = getelementptr inbounds nuw { i64, i64 }, ptr %14, i32 0, i32 0
  %60 = load i64, ptr %59, align 4
  %61 = getelementptr inbounds nuw { i64, i64 }, ptr %14, i32 0, i32 1
  %62 = load i64, ptr %61, align 4
  %63 = call ptr @loadtree(ptr noundef %56, i64 %60, i64 %62, ptr noundef %57, i32 noundef 536870912, ptr noundef %58)
  store ptr %63, ptr %13, align 8, !tbaa !65
  %64 = load ptr, ptr %13, align 8, !tbaa !65
  %65 = load ptr, ptr %8, align 8, !tbaa !14
  %66 = getelementptr inbounds nuw %struct.tree, ptr %65, i32 0, i32 2
  store ptr %64, ptr %66, align 8, !tbaa !17
  br label %67

67:                                               ; preds = %41, %36
  br label %68

68:                                               ; preds = %67
  %69 = load ptr, ptr %11, align 8, !tbaa !15
  %rds.field.ptr11 = getelementptr inbounds %struct.bnode, ptr %69, i32 0, i32 9
  %rds.field.val12 = load ptr, ptr %rds.field.ptr11, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val12, i32 0, i32 3, i32 1)
  %70 = getelementptr inbounds nuw %struct.bnode, ptr %69, i32 0, i32 10
  %71 = load ptr, ptr %70, align 8, !tbaa !44
  store ptr %71, ptr %11, align 8, !tbaa !15
  br label %33, !llvm.loop !66

72:                                               ; preds = %33
  br label %73

73:                                               ; preds = %72
  %74 = load i32, ptr %12, align 4, !tbaa !5
  %75 = add nsw i32 %74, -1
  store i32 %75, ptr %12, align 4, !tbaa !5
  br label %22, !llvm.loop !67

76:                                               ; preds = %22
  %77 = load ptr, ptr %8, align 8, !tbaa !14
  %78 = getelementptr inbounds nuw %struct.tree, ptr %77, i32 0, i32 2
  %79 = load ptr, ptr %78, align 8, !tbaa !17
  %80 = call double @hackcofm(ptr noundef %79)
  %81 = load ptr, ptr %8, align 8, !tbaa !14
  %82 = getelementptr inbounds nuw %struct.tree, ptr %81, i32 0, i32 2
  %83 = load ptr, ptr %82, align 8, !tbaa !17
  call void @llvm.lifetime.end.p0(i64 4, ptr %15) #11
  call void @llvm.lifetime.end.p0(i64 16, ptr %14) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %13) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %12) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %11) #11
  ret ptr %83
}

; Function Attrs: nounwind uwtable
define dso_local void @computegrav(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca double, align 8
  %7 = alloca double, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8, !tbaa !14
  store i32 %1, ptr %4, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %6) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %7) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %8) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %9) #11
  %10 = load ptr, ptr %3, align 8, !tbaa !14
  %11 = getelementptr inbounds nuw %struct.tree, ptr %10, i32 0, i32 1
  %12 = load double, ptr %11, align 8, !tbaa !22
  store double %12, ptr %6, align 8, !tbaa !21
  store double 6.250000e-03, ptr %7, align 8, !tbaa !21
  %13 = load i32, ptr @NumNodes, align 4, !tbaa !5
  %14 = sub nsw i32 %13, 1
  store i32 %14, ptr %5, align 4, !tbaa !5
  br label %15

15:                                               ; preds = %33, %2
  %16 = load i32, ptr %5, align 4, !tbaa !5
  %17 = icmp sge i32 %16, 0
  br i1 %17, label %18, label %36

18:                                               ; preds = %15
  %19 = load ptr, ptr %3, align 8, !tbaa !14
  %rds.field.ptr = getelementptr inbounds %struct.tree, ptr %19, i32 0, i32 3
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %rds.field.ptr1 = getelementptr inbounds %struct.tree, ptr %19, i32 0, i32 4
  %rds.field.val2 = load ptr, ptr %rds.field.ptr1, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val2, i32 0, i32 3, i32 1)
  %20 = getelementptr inbounds nuw %struct.tree, ptr %19, i32 0, i32 2
  %21 = load ptr, ptr %20, align 8, !tbaa !17
  store ptr %21, ptr %8, align 8, !tbaa !65
  %22 = load ptr, ptr %3, align 8, !tbaa !14
  %23 = getelementptr inbounds nuw %struct.tree, ptr %22, i32 0, i32 4
  %24 = load i32, ptr %5, align 4, !tbaa !5
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [64 x ptr], ptr %23, i64 0, i64 %25
  %27 = load ptr, ptr %26, align 8, !tbaa !15
  store ptr %27, ptr %9, align 8, !tbaa !15
  %28 = load double, ptr %6, align 8, !tbaa !21
  %29 = load ptr, ptr %8, align 8, !tbaa !65
  %30 = load ptr, ptr %9, align 8, !tbaa !15
  %31 = load i32, ptr %4, align 4, !tbaa !5
  %32 = load double, ptr %7, align 8, !tbaa !21
  call void @grav(double noundef %28, ptr noundef %29, ptr noundef %30, i32 noundef %31, double noundef %32)
  br label %33

33:                                               ; preds = %18
  %34 = load i32, ptr %5, align 4, !tbaa !5
  %35 = add nsw i32 %34, -1
  store i32 %35, ptr %5, align 4, !tbaa !5
  br label %15, !llvm.loop !68

36:                                               ; preds = %15
  call void @llvm.lifetime.end.p0(i64 8, ptr %9) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %8) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %7) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %6) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #11
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @vp(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca double, align 8
  %6 = alloca [3 x double], align 16
  %7 = alloca [3 x double], align 16
  %8 = alloca [3 x double], align 16
  %9 = alloca [3 x double], align 16
  %10 = alloca [3 x double], align 16
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca double, align 8
  %18 = alloca double, align 8
  %19 = alloca double, align 8
  %20 = alloca i32, align 4
  %21 = alloca double, align 8
  %22 = alloca double, align 8
  %23 = alloca double, align 8
  %24 = alloca i32, align 4
  %25 = alloca double, align 8
  %26 = alloca double, align 8
  %27 = alloca double, align 8
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca double, align 8
  %34 = alloca double, align 8
  %35 = alloca double, align 8
  store ptr %0, ptr %3, align 8, !tbaa !15
  store i32 %1, ptr %4, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 8, ptr %5) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %6) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %7) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %8) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %9) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %10) #11
  store double 6.250000e-03, ptr %5, align 8, !tbaa !21
  %36 = load ptr, ptr %3, align 8, !tbaa !15
  %37 = icmp ne ptr %36, null
  br i1 %37, label %38, label %40

38:                                               ; preds = %2
  call void @llvm.lifetime.start.p0(i64 8, ptr %11) #11
  %39 = load ptr, ptr %3, align 8, !tbaa !15
  store ptr %39, ptr %11, align 8, !tbaa !15
  call void @llvm.lifetime.end.p0(i64 8, ptr %11) #11
  br label %40

40:                                               ; preds = %38, %2
  br label %41

41:                                               ; preds = %459, %40
  %42 = load ptr, ptr %3, align 8, !tbaa !15
  %43 = icmp ne ptr %42, null
  br i1 %43, label %44, label %463

44:                                               ; preds = %41
  call void @llvm.lifetime.start.p0(i64 4, ptr %12) #11
  store i32 0, ptr %12, align 4, !tbaa !5
  br label %45

45:                                               ; preds = %58, %44
  %46 = load i32, ptr %12, align 4, !tbaa !5
  %47 = icmp slt i32 %46, 3
  br i1 %47, label %48, label %61

48:                                               ; preds = %45
  %49 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr53 = getelementptr inbounds %struct.bnode, ptr %49, i32 0, i32 9
  %rds.field.val54 = load ptr, ptr %rds.field.ptr53, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val54, i32 0, i32 3, i32 1)
  %rds.field.ptr55 = getelementptr inbounds %struct.bnode, ptr %49, i32 0, i32 10
  %rds.field.val56 = load ptr, ptr %rds.field.ptr55, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val56, i32 0, i32 3, i32 1)
  %50 = getelementptr inbounds nuw %struct.bnode, ptr %49, i32 0, i32 7
  %51 = load i32, ptr %12, align 4, !tbaa !5
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds [3 x double], ptr %50, i64 0, i64 %52
  %54 = load double, ptr %53, align 8, !tbaa !21
  %55 = load i32, ptr %12, align 4, !tbaa !5
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds [3 x double], ptr %6, i64 0, i64 %56
  store double %54, ptr %57, align 8, !tbaa !21
  br label %58

58:                                               ; preds = %48
  %59 = load i32, ptr %12, align 4, !tbaa !5
  %60 = add nsw i32 %59, 1
  store i32 %60, ptr %12, align 4, !tbaa !5
  br label %45, !llvm.loop !69

61:                                               ; preds = %45
  call void @llvm.lifetime.end.p0(i64 4, ptr %12) #11
  %62 = load i32, ptr %4, align 4, !tbaa !5
  %63 = icmp sgt i32 %62, 0
  br i1 %63, label %64, label %143

64:                                               ; preds = %61
  call void @llvm.lifetime.start.p0(i64 4, ptr %13) #11
  store i32 0, ptr %13, align 4, !tbaa !5
  br label %65

65:                                               ; preds = %83, %64
  %66 = load i32, ptr %13, align 4, !tbaa !5
  %67 = icmp slt i32 %66, 3
  br i1 %67, label %68, label %86

68:                                               ; preds = %65
  %69 = load i32, ptr %13, align 4, !tbaa !5
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds [3 x double], ptr %6, i64 0, i64 %70
  %72 = load double, ptr %71, align 8, !tbaa !21
  %73 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr49 = getelementptr inbounds %struct.bnode, ptr %73, i32 0, i32 9
  %rds.field.val50 = load ptr, ptr %rds.field.ptr49, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val50, i32 0, i32 3, i32 1)
  %rds.field.ptr51 = getelementptr inbounds %struct.bnode, ptr %73, i32 0, i32 10
  %rds.field.val52 = load ptr, ptr %rds.field.ptr51, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val52, i32 0, i32 3, i32 1)
  %74 = getelementptr inbounds nuw %struct.bnode, ptr %73, i32 0, i32 6
  %75 = load i32, ptr %13, align 4, !tbaa !5
  %76 = sext i32 %75 to i64
  %77 = getelementptr inbounds [3 x double], ptr %74, i64 0, i64 %76
  %78 = load double, ptr %77, align 8, !tbaa !21
  %79 = fsub double %72, %78
  %80 = load i32, ptr %13, align 4, !tbaa !5
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds [3 x double], ptr %7, i64 0, i64 %81
  store double %79, ptr %82, align 8, !tbaa !21
  br label %83

83:                                               ; preds = %68
  %84 = load i32, ptr %13, align 4, !tbaa !5
  %85 = add nsw i32 %84, 1
  store i32 %85, ptr %13, align 4, !tbaa !5
  br label %65, !llvm.loop !70

86:                                               ; preds = %65
  call void @llvm.lifetime.end.p0(i64 4, ptr %13) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %14) #11
  store i32 0, ptr %14, align 4, !tbaa !5
  br label %87

87:                                               ; preds = %100, %86
  %88 = load i32, ptr %14, align 4, !tbaa !5
  %89 = icmp slt i32 %88, 3
  br i1 %89, label %90, label %103

90:                                               ; preds = %87
  %91 = load i32, ptr %14, align 4, !tbaa !5
  %92 = sext i32 %91 to i64
  %93 = getelementptr inbounds [3 x double], ptr %7, i64 0, i64 %92
  %94 = load double, ptr %93, align 8, !tbaa !21
  %95 = load double, ptr %5, align 8, !tbaa !21
  %96 = fmul double %94, %95
  %97 = load i32, ptr %14, align 4, !tbaa !5
  %98 = sext i32 %97 to i64
  %99 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 %98
  store double %96, ptr %99, align 8, !tbaa !21
  br label %100

100:                                              ; preds = %90
  %101 = load i32, ptr %14, align 4, !tbaa !5
  %102 = add nsw i32 %101, 1
  store i32 %102, ptr %14, align 4, !tbaa !5
  br label %87, !llvm.loop !71

103:                                              ; preds = %87
  call void @llvm.lifetime.end.p0(i64 4, ptr %14) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %15) #11
  store i32 0, ptr %15, align 4, !tbaa !5
  br label %104

104:                                              ; preds = %122, %103
  %105 = load i32, ptr %15, align 4, !tbaa !5
  %106 = icmp slt i32 %105, 3
  br i1 %106, label %107, label %125

107:                                              ; preds = %104
  %108 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr45 = getelementptr inbounds %struct.bnode, ptr %108, i32 0, i32 9
  %rds.field.val46 = load ptr, ptr %rds.field.ptr45, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val46, i32 0, i32 3, i32 1)
  %rds.field.ptr47 = getelementptr inbounds %struct.bnode, ptr %108, i32 0, i32 10
  %rds.field.val48 = load ptr, ptr %rds.field.ptr47, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val48, i32 0, i32 3, i32 1)
  %109 = getelementptr inbounds nuw %struct.bnode, ptr %108, i32 0, i32 5
  %110 = load i32, ptr %15, align 4, !tbaa !5
  %111 = sext i32 %110 to i64
  %112 = getelementptr inbounds [3 x double], ptr %109, i64 0, i64 %111
  %113 = load double, ptr %112, align 8, !tbaa !21
  %114 = load i32, ptr %15, align 4, !tbaa !5
  %115 = sext i32 %114 to i64
  %116 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 %115
  %117 = load double, ptr %116, align 8, !tbaa !21
  %118 = fadd double %113, %117
  %119 = load i32, ptr %15, align 4, !tbaa !5
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 %120
  store double %118, ptr %121, align 8, !tbaa !21
  br label %122

122:                                              ; preds = %107
  %123 = load i32, ptr %15, align 4, !tbaa !5
  %124 = add nsw i32 %123, 1
  store i32 %124, ptr %15, align 4, !tbaa !5
  br label %104, !llvm.loop !72

125:                                              ; preds = %104
  call void @llvm.lifetime.end.p0(i64 4, ptr %15) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %16) #11
  store i32 0, ptr %16, align 4, !tbaa !5
  br label %126

126:                                              ; preds = %139, %125
  %127 = load i32, ptr %16, align 4, !tbaa !5
  %128 = icmp slt i32 %127, 3
  br i1 %128, label %129, label %142

129:                                              ; preds = %126
  %130 = load i32, ptr %16, align 4, !tbaa !5
  %131 = sext i32 %130 to i64
  %132 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 %131
  %133 = load double, ptr %132, align 8, !tbaa !21
  %134 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr41 = getelementptr inbounds %struct.bnode, ptr %134, i32 0, i32 9
  %rds.field.val42 = load ptr, ptr %rds.field.ptr41, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val42, i32 0, i32 3, i32 1)
  %rds.field.ptr43 = getelementptr inbounds %struct.bnode, ptr %134, i32 0, i32 10
  %rds.field.val44 = load ptr, ptr %rds.field.ptr43, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val44, i32 0, i32 3, i32 1)
  %135 = getelementptr inbounds nuw %struct.bnode, ptr %134, i32 0, i32 5
  %136 = load i32, ptr %16, align 4, !tbaa !5
  %137 = sext i32 %136 to i64
  %138 = getelementptr inbounds [3 x double], ptr %135, i64 0, i64 %137
  store double %133, ptr %138, align 8, !tbaa !21
  br label %139

139:                                              ; preds = %129
  %140 = load i32, ptr %16, align 4, !tbaa !5
  %141 = add nsw i32 %140, 1
  store i32 %141, ptr %16, align 4, !tbaa !5
  br label %126, !llvm.loop !73

142:                                              ; preds = %126
  call void @llvm.lifetime.end.p0(i64 4, ptr %16) #11
  br label %143

143:                                              ; preds = %142, %61
  call void @llvm.lifetime.start.p0(i64 8, ptr %17) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %18) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %19) #11
  %144 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr = getelementptr inbounds %struct.bnode, ptr %144, i32 0, i32 9
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %rds.field.ptr1 = getelementptr inbounds %struct.bnode, ptr %144, i32 0, i32 10
  %rds.field.val2 = load ptr, ptr %rds.field.ptr1, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val2, i32 0, i32 3, i32 1)
  %145 = getelementptr inbounds nuw %struct.bnode, ptr %144, i32 0, i32 2
  %146 = getelementptr inbounds [3 x double], ptr %145, i64 0, i64 0
  %147 = load double, ptr %146, align 8, !tbaa !21
  store double %147, ptr %17, align 8, !tbaa !21
  %148 = load ptr, ptr %3, align 8, !tbaa !15
  %149 = getelementptr inbounds nuw %struct.bnode, ptr %148, i32 0, i32 2
  %150 = getelementptr inbounds [3 x double], ptr %149, i64 0, i64 1
  %151 = load double, ptr %150, align 8, !tbaa !21
  store double %151, ptr %18, align 8, !tbaa !21
  %152 = load ptr, ptr %3, align 8, !tbaa !15
  %153 = getelementptr inbounds nuw %struct.bnode, ptr %152, i32 0, i32 2
  %154 = getelementptr inbounds [3 x double], ptr %153, i64 0, i64 2
  %155 = load double, ptr %154, align 8, !tbaa !21
  store double %155, ptr %19, align 8, !tbaa !21
  %156 = load double, ptr %17, align 8, !tbaa !21
  %157 = call i1 @llvm.is.fpclass.f64(double %156, i32 3)
  br i1 %157, label %158, label %160

158:                                              ; preds = %143
  %159 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 99)
  call void @abort() #14
  unreachable

160:                                              ; preds = %143
  %161 = load double, ptr %18, align 8, !tbaa !21
  %162 = call i1 @llvm.is.fpclass.f64(double %161, i32 3)
  br i1 %162, label %163, label %165

163:                                              ; preds = %160
  %164 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 98)
  call void @abort() #14
  unreachable

165:                                              ; preds = %160
  %166 = load double, ptr %19, align 8, !tbaa !21
  %167 = call i1 @llvm.is.fpclass.f64(double %166, i32 3)
  br i1 %167, label %168, label %170

168:                                              ; preds = %165
  %169 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 97)
  call void @abort() #14
  unreachable

170:                                              ; preds = %165
  %171 = load double, ptr %17, align 8, !tbaa !21
  %172 = call double @llvm.fabs.f64(double %171)
  %173 = fcmp olt double %172, 1.000000e+01
  br i1 %173, label %176, label %174

174:                                              ; preds = %170
  %175 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 96)
  call void @abort() #14
  unreachable

176:                                              ; preds = %170
  %177 = load double, ptr %18, align 8, !tbaa !21
  %178 = call double @llvm.fabs.f64(double %177)
  %179 = fcmp olt double %178, 1.000000e+01
  br i1 %179, label %182, label %180

180:                                              ; preds = %176
  %181 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 95)
  call void @abort() #14
  unreachable

182:                                              ; preds = %176
  %183 = load double, ptr %19, align 8, !tbaa !21
  %184 = call double @llvm.fabs.f64(double %183)
  %185 = fcmp olt double %184, 1.000000e+01
  br i1 %185, label %188, label %186

186:                                              ; preds = %182
  %187 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 94)
  call void @abort() #14
  unreachable

188:                                              ; preds = %182
  call void @llvm.lifetime.end.p0(i64 8, ptr %19) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %18) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %17) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %20) #11
  store i32 0, ptr %20, align 4, !tbaa !5
  br label %189

189:                                              ; preds = %202, %188
  %190 = load i32, ptr %20, align 4, !tbaa !5
  %191 = icmp slt i32 %190, 3
  br i1 %191, label %192, label %205

192:                                              ; preds = %189
  %193 = load i32, ptr %20, align 4, !tbaa !5
  %194 = sext i32 %193 to i64
  %195 = getelementptr inbounds [3 x double], ptr %6, i64 0, i64 %194
  %196 = load double, ptr %195, align 8, !tbaa !21
  %197 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr37 = getelementptr inbounds %struct.bnode, ptr %197, i32 0, i32 9
  %rds.field.val38 = load ptr, ptr %rds.field.ptr37, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val38, i32 0, i32 3, i32 1)
  %rds.field.ptr39 = getelementptr inbounds %struct.bnode, ptr %197, i32 0, i32 10
  %rds.field.val40 = load ptr, ptr %rds.field.ptr39, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val40, i32 0, i32 3, i32 1)
  %198 = getelementptr inbounds nuw %struct.bnode, ptr %197, i32 0, i32 6
  %199 = load i32, ptr %20, align 4, !tbaa !5
  %200 = sext i32 %199 to i64
  %201 = getelementptr inbounds [3 x double], ptr %198, i64 0, i64 %200
  store double %196, ptr %201, align 8, !tbaa !21
  br label %202

202:                                              ; preds = %192
  %203 = load i32, ptr %20, align 4, !tbaa !5
  %204 = add nsw i32 %203, 1
  store i32 %204, ptr %20, align 4, !tbaa !5
  br label %189, !llvm.loop !74

205:                                              ; preds = %189
  call void @llvm.lifetime.end.p0(i64 4, ptr %20) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %21) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %22) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %23) #11
  %206 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr3 = getelementptr inbounds %struct.bnode, ptr %206, i32 0, i32 9
  %rds.field.val4 = load ptr, ptr %rds.field.ptr3, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val4, i32 0, i32 3, i32 1)
  %rds.field.ptr5 = getelementptr inbounds %struct.bnode, ptr %206, i32 0, i32 10
  %rds.field.val6 = load ptr, ptr %rds.field.ptr5, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val6, i32 0, i32 3, i32 1)
  %207 = getelementptr inbounds nuw %struct.bnode, ptr %206, i32 0, i32 6
  %208 = getelementptr inbounds [3 x double], ptr %207, i64 0, i64 0
  %209 = load double, ptr %208, align 8, !tbaa !21
  store double %209, ptr %21, align 8, !tbaa !21
  %210 = load ptr, ptr %3, align 8, !tbaa !15
  %211 = getelementptr inbounds nuw %struct.bnode, ptr %210, i32 0, i32 6
  %212 = getelementptr inbounds [3 x double], ptr %211, i64 0, i64 1
  %213 = load double, ptr %212, align 8, !tbaa !21
  store double %213, ptr %22, align 8, !tbaa !21
  %214 = load ptr, ptr %3, align 8, !tbaa !15
  %215 = getelementptr inbounds nuw %struct.bnode, ptr %214, i32 0, i32 6
  %216 = getelementptr inbounds [3 x double], ptr %215, i64 0, i64 2
  %217 = load double, ptr %216, align 8, !tbaa !21
  store double %217, ptr %23, align 8, !tbaa !21
  %218 = load double, ptr %21, align 8, !tbaa !21
  %219 = call i1 @llvm.is.fpclass.f64(double %218, i32 3)
  br i1 %219, label %220, label %222

220:                                              ; preds = %205
  %221 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 89)
  call void @abort() #14
  unreachable

222:                                              ; preds = %205
  %223 = load double, ptr %22, align 8, !tbaa !21
  %224 = call i1 @llvm.is.fpclass.f64(double %223, i32 3)
  br i1 %224, label %225, label %227

225:                                              ; preds = %222
  %226 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 88)
  call void @abort() #14
  unreachable

227:                                              ; preds = %222
  %228 = load double, ptr %23, align 8, !tbaa !21
  %229 = call i1 @llvm.is.fpclass.f64(double %228, i32 3)
  br i1 %229, label %230, label %232

230:                                              ; preds = %227
  %231 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 87)
  call void @abort() #14
  unreachable

232:                                              ; preds = %227
  %233 = load double, ptr %21, align 8, !tbaa !21
  %234 = call double @llvm.fabs.f64(double %233)
  %235 = fcmp olt double %234, 1.000000e+04
  br i1 %235, label %238, label %236

236:                                              ; preds = %232
  %237 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 86)
  call void @abort() #14
  unreachable

238:                                              ; preds = %232
  %239 = load double, ptr %22, align 8, !tbaa !21
  %240 = call double @llvm.fabs.f64(double %239)
  %241 = fcmp olt double %240, 1.000000e+04
  br i1 %241, label %244, label %242

242:                                              ; preds = %238
  %243 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 85)
  call void @abort() #14
  unreachable

244:                                              ; preds = %238
  %245 = load double, ptr %23, align 8, !tbaa !21
  %246 = call double @llvm.fabs.f64(double %245)
  %247 = fcmp olt double %246, 1.000000e+04
  br i1 %247, label %250, label %248

248:                                              ; preds = %244
  %249 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 84)
  call void @abort() #14
  unreachable

250:                                              ; preds = %244
  call void @llvm.lifetime.end.p0(i64 8, ptr %23) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %22) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %21) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %24) #11
  store i32 0, ptr %24, align 4, !tbaa !5
  br label %251

251:                                              ; preds = %266, %250
  %252 = load i32, ptr %24, align 4, !tbaa !5
  %253 = icmp slt i32 %252, 3
  br i1 %253, label %254, label %269

254:                                              ; preds = %251
  %255 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr33 = getelementptr inbounds %struct.bnode, ptr %255, i32 0, i32 9
  %rds.field.val34 = load ptr, ptr %rds.field.ptr33, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val34, i32 0, i32 3, i32 1)
  %rds.field.ptr35 = getelementptr inbounds %struct.bnode, ptr %255, i32 0, i32 10
  %rds.field.val36 = load ptr, ptr %rds.field.ptr35, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val36, i32 0, i32 3, i32 1)
  %256 = getelementptr inbounds nuw %struct.bnode, ptr %255, i32 0, i32 6
  %257 = load i32, ptr %24, align 4, !tbaa !5
  %258 = sext i32 %257 to i64
  %259 = getelementptr inbounds [3 x double], ptr %256, i64 0, i64 %258
  %260 = load double, ptr %259, align 8, !tbaa !21
  %261 = load double, ptr %5, align 8, !tbaa !21
  %262 = fmul double %260, %261
  %263 = load i32, ptr %24, align 4, !tbaa !5
  %264 = sext i32 %263 to i64
  %265 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 %264
  store double %262, ptr %265, align 8, !tbaa !21
  br label %266

266:                                              ; preds = %254
  %267 = load i32, ptr %24, align 4, !tbaa !5
  %268 = add nsw i32 %267, 1
  store i32 %268, ptr %24, align 4, !tbaa !5
  br label %251, !llvm.loop !75

269:                                              ; preds = %251
  call void @llvm.lifetime.end.p0(i64 4, ptr %24) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %25) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %26) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %27) #11
  %270 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr7 = getelementptr inbounds %struct.bnode, ptr %270, i32 0, i32 9
  %rds.field.val8 = load ptr, ptr %rds.field.ptr7, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val8, i32 0, i32 3, i32 1)
  %rds.field.ptr9 = getelementptr inbounds %struct.bnode, ptr %270, i32 0, i32 10
  %rds.field.val10 = load ptr, ptr %rds.field.ptr9, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val10, i32 0, i32 3, i32 1)
  %271 = getelementptr inbounds nuw %struct.bnode, ptr %270, i32 0, i32 5
  %272 = getelementptr inbounds [3 x double], ptr %271, i64 0, i64 0
  %273 = load double, ptr %272, align 8, !tbaa !21
  store double %273, ptr %25, align 8, !tbaa !21
  %274 = load ptr, ptr %3, align 8, !tbaa !15
  %275 = getelementptr inbounds nuw %struct.bnode, ptr %274, i32 0, i32 5
  %276 = getelementptr inbounds [3 x double], ptr %275, i64 0, i64 1
  %277 = load double, ptr %276, align 8, !tbaa !21
  store double %277, ptr %26, align 8, !tbaa !21
  %278 = load ptr, ptr %3, align 8, !tbaa !15
  %279 = getelementptr inbounds nuw %struct.bnode, ptr %278, i32 0, i32 5
  %280 = getelementptr inbounds [3 x double], ptr %279, i64 0, i64 2
  %281 = load double, ptr %280, align 8, !tbaa !21
  store double %281, ptr %27, align 8, !tbaa !21
  %282 = load double, ptr %25, align 8, !tbaa !21
  %283 = call i1 @llvm.is.fpclass.f64(double %282, i32 3)
  br i1 %283, label %284, label %286

284:                                              ; preds = %269
  %285 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 79)
  call void @abort() #14
  unreachable

286:                                              ; preds = %269
  %287 = load double, ptr %26, align 8, !tbaa !21
  %288 = call i1 @llvm.is.fpclass.f64(double %287, i32 3)
  br i1 %288, label %289, label %291

289:                                              ; preds = %286
  %290 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 78)
  call void @abort() #14
  unreachable

291:                                              ; preds = %286
  %292 = load double, ptr %27, align 8, !tbaa !21
  %293 = call i1 @llvm.is.fpclass.f64(double %292, i32 3)
  br i1 %293, label %294, label %296

294:                                              ; preds = %291
  %295 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 77)
  call void @abort() #14
  unreachable

296:                                              ; preds = %291
  %297 = load double, ptr %25, align 8, !tbaa !21
  %298 = call double @llvm.fabs.f64(double %297)
  %299 = fcmp olt double %298, 1.000000e+04
  br i1 %299, label %302, label %300

300:                                              ; preds = %296
  %301 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 76)
  call void @abort() #14
  unreachable

302:                                              ; preds = %296
  %303 = load double, ptr %26, align 8, !tbaa !21
  %304 = call double @llvm.fabs.f64(double %303)
  %305 = fcmp olt double %304, 1.000000e+04
  br i1 %305, label %308, label %306

306:                                              ; preds = %302
  %307 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 75)
  call void @abort() #14
  unreachable

308:                                              ; preds = %302
  %309 = load double, ptr %27, align 8, !tbaa !21
  %310 = call double @llvm.fabs.f64(double %309)
  %311 = fcmp olt double %310, 1.000000e+04
  br i1 %311, label %314, label %312

312:                                              ; preds = %308
  %313 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 74)
  call void @abort() #14
  unreachable

314:                                              ; preds = %308
  call void @llvm.lifetime.end.p0(i64 8, ptr %27) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %26) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %25) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %28) #11
  store i32 0, ptr %28, align 4, !tbaa !5
  br label %315

315:                                              ; preds = %333, %314
  %316 = load i32, ptr %28, align 4, !tbaa !5
  %317 = icmp slt i32 %316, 3
  br i1 %317, label %318, label %336

318:                                              ; preds = %315
  %319 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr29 = getelementptr inbounds %struct.bnode, ptr %319, i32 0, i32 9
  %rds.field.val30 = load ptr, ptr %rds.field.ptr29, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val30, i32 0, i32 3, i32 1)
  %rds.field.ptr31 = getelementptr inbounds %struct.bnode, ptr %319, i32 0, i32 10
  %rds.field.val32 = load ptr, ptr %rds.field.ptr31, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val32, i32 0, i32 3, i32 1)
  %320 = getelementptr inbounds nuw %struct.bnode, ptr %319, i32 0, i32 5
  %321 = load i32, ptr %28, align 4, !tbaa !5
  %322 = sext i32 %321 to i64
  %323 = getelementptr inbounds [3 x double], ptr %320, i64 0, i64 %322
  %324 = load double, ptr %323, align 8, !tbaa !21
  %325 = load i32, ptr %28, align 4, !tbaa !5
  %326 = sext i32 %325 to i64
  %327 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 %326
  %328 = load double, ptr %327, align 8, !tbaa !21
  %329 = fadd double %324, %328
  %330 = load i32, ptr %28, align 4, !tbaa !5
  %331 = sext i32 %330 to i64
  %332 = getelementptr inbounds [3 x double], ptr %9, i64 0, i64 %331
  store double %329, ptr %332, align 8, !tbaa !21
  br label %333

333:                                              ; preds = %318
  %334 = load i32, ptr %28, align 4, !tbaa !5
  %335 = add nsw i32 %334, 1
  store i32 %335, ptr %28, align 4, !tbaa !5
  br label %315, !llvm.loop !76

336:                                              ; preds = %315
  call void @llvm.lifetime.end.p0(i64 4, ptr %28) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %29) #11
  store i32 0, ptr %29, align 4, !tbaa !5
  br label %337

337:                                              ; preds = %349, %336
  %338 = load i32, ptr %29, align 4, !tbaa !5
  %339 = icmp slt i32 %338, 3
  br i1 %339, label %340, label %352

340:                                              ; preds = %337
  %341 = load i32, ptr %29, align 4, !tbaa !5
  %342 = sext i32 %341 to i64
  %343 = getelementptr inbounds [3 x double], ptr %9, i64 0, i64 %342
  %344 = load double, ptr %343, align 8, !tbaa !21
  %345 = fmul double %344, 1.250000e-02
  %346 = load i32, ptr %29, align 4, !tbaa !5
  %347 = sext i32 %346 to i64
  %348 = getelementptr inbounds [3 x double], ptr %10, i64 0, i64 %347
  store double %345, ptr %348, align 8, !tbaa !21
  br label %349

349:                                              ; preds = %340
  %350 = load i32, ptr %29, align 4, !tbaa !5
  %351 = add nsw i32 %350, 1
  store i32 %351, ptr %29, align 4, !tbaa !5
  br label %337, !llvm.loop !77

352:                                              ; preds = %337
  call void @llvm.lifetime.end.p0(i64 4, ptr %29) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %30) #11
  store i32 0, ptr %30, align 4, !tbaa !5
  br label %353

353:                                              ; preds = %371, %352
  %354 = load i32, ptr %30, align 4, !tbaa !5
  %355 = icmp slt i32 %354, 3
  br i1 %355, label %356, label %374

356:                                              ; preds = %353
  %357 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr25 = getelementptr inbounds %struct.bnode, ptr %357, i32 0, i32 9
  %rds.field.val26 = load ptr, ptr %rds.field.ptr25, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val26, i32 0, i32 3, i32 1)
  %rds.field.ptr27 = getelementptr inbounds %struct.bnode, ptr %357, i32 0, i32 10
  %rds.field.val28 = load ptr, ptr %rds.field.ptr27, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val28, i32 0, i32 3, i32 1)
  %358 = getelementptr inbounds nuw %struct.bnode, ptr %357, i32 0, i32 2
  %359 = load i32, ptr %30, align 4, !tbaa !5
  %360 = sext i32 %359 to i64
  %361 = getelementptr inbounds [3 x double], ptr %358, i64 0, i64 %360
  %362 = load double, ptr %361, align 8, !tbaa !21
  %363 = load i32, ptr %30, align 4, !tbaa !5
  %364 = sext i32 %363 to i64
  %365 = getelementptr inbounds [3 x double], ptr %10, i64 0, i64 %364
  %366 = load double, ptr %365, align 8, !tbaa !21
  %367 = fadd double %362, %366
  %368 = load i32, ptr %30, align 4, !tbaa !5
  %369 = sext i32 %368 to i64
  %370 = getelementptr inbounds [3 x double], ptr %10, i64 0, i64 %369
  store double %367, ptr %370, align 8, !tbaa !21
  br label %371

371:                                              ; preds = %356
  %372 = load i32, ptr %30, align 4, !tbaa !5
  %373 = add nsw i32 %372, 1
  store i32 %373, ptr %30, align 4, !tbaa !5
  br label %353, !llvm.loop !78

374:                                              ; preds = %353
  call void @llvm.lifetime.end.p0(i64 4, ptr %30) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %31) #11
  store i32 0, ptr %31, align 4, !tbaa !5
  br label %375

375:                                              ; preds = %388, %374
  %376 = load i32, ptr %31, align 4, !tbaa !5
  %377 = icmp slt i32 %376, 3
  br i1 %377, label %378, label %391

378:                                              ; preds = %375
  %379 = load i32, ptr %31, align 4, !tbaa !5
  %380 = sext i32 %379 to i64
  %381 = getelementptr inbounds [3 x double], ptr %10, i64 0, i64 %380
  %382 = load double, ptr %381, align 8, !tbaa !21
  %383 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr21 = getelementptr inbounds %struct.bnode, ptr %383, i32 0, i32 9
  %rds.field.val22 = load ptr, ptr %rds.field.ptr21, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val22, i32 0, i32 3, i32 1)
  %rds.field.ptr23 = getelementptr inbounds %struct.bnode, ptr %383, i32 0, i32 10
  %rds.field.val24 = load ptr, ptr %rds.field.ptr23, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val24, i32 0, i32 3, i32 1)
  %384 = getelementptr inbounds nuw %struct.bnode, ptr %383, i32 0, i32 2
  %385 = load i32, ptr %31, align 4, !tbaa !5
  %386 = sext i32 %385 to i64
  %387 = getelementptr inbounds [3 x double], ptr %384, i64 0, i64 %386
  store double %382, ptr %387, align 8, !tbaa !21
  br label %388

388:                                              ; preds = %378
  %389 = load i32, ptr %31, align 4, !tbaa !5
  %390 = add nsw i32 %389, 1
  store i32 %390, ptr %31, align 4, !tbaa !5
  br label %375, !llvm.loop !79

391:                                              ; preds = %375
  call void @llvm.lifetime.end.p0(i64 4, ptr %31) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %32) #11
  store i32 0, ptr %32, align 4, !tbaa !5
  br label %392

392:                                              ; preds = %410, %391
  %393 = load i32, ptr %32, align 4, !tbaa !5
  %394 = icmp slt i32 %393, 3
  br i1 %394, label %395, label %413

395:                                              ; preds = %392
  %396 = load i32, ptr %32, align 4, !tbaa !5
  %397 = sext i32 %396 to i64
  %398 = getelementptr inbounds [3 x double], ptr %9, i64 0, i64 %397
  %399 = load double, ptr %398, align 8, !tbaa !21
  %400 = load i32, ptr %32, align 4, !tbaa !5
  %401 = sext i32 %400 to i64
  %402 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 %401
  %403 = load double, ptr %402, align 8, !tbaa !21
  %404 = fadd double %399, %403
  %405 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr17 = getelementptr inbounds %struct.bnode, ptr %405, i32 0, i32 9
  %rds.field.val18 = load ptr, ptr %rds.field.ptr17, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val18, i32 0, i32 3, i32 1)
  %rds.field.ptr19 = getelementptr inbounds %struct.bnode, ptr %405, i32 0, i32 10
  %rds.field.val20 = load ptr, ptr %rds.field.ptr19, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val20, i32 0, i32 3, i32 1)
  %406 = getelementptr inbounds nuw %struct.bnode, ptr %405, i32 0, i32 5
  %407 = load i32, ptr %32, align 4, !tbaa !5
  %408 = sext i32 %407 to i64
  %409 = getelementptr inbounds [3 x double], ptr %406, i64 0, i64 %408
  store double %404, ptr %409, align 8, !tbaa !21
  br label %410

410:                                              ; preds = %395
  %411 = load i32, ptr %32, align 4, !tbaa !5
  %412 = add nsw i32 %411, 1
  store i32 %412, ptr %32, align 4, !tbaa !5
  br label %392, !llvm.loop !80

413:                                              ; preds = %392
  call void @llvm.lifetime.end.p0(i64 4, ptr %32) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %33) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %34) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %35) #11
  %414 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr11 = getelementptr inbounds %struct.bnode, ptr %414, i32 0, i32 9
  %rds.field.val12 = load ptr, ptr %rds.field.ptr11, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val12, i32 0, i32 3, i32 1)
  %rds.field.ptr13 = getelementptr inbounds %struct.bnode, ptr %414, i32 0, i32 10
  %rds.field.val14 = load ptr, ptr %rds.field.ptr13, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val14, i32 0, i32 3, i32 1)
  %415 = getelementptr inbounds nuw %struct.bnode, ptr %414, i32 0, i32 2
  %416 = getelementptr inbounds [3 x double], ptr %415, i64 0, i64 0
  %417 = load double, ptr %416, align 8, !tbaa !21
  store double %417, ptr %33, align 8, !tbaa !21
  %418 = load ptr, ptr %3, align 8, !tbaa !15
  %419 = getelementptr inbounds nuw %struct.bnode, ptr %418, i32 0, i32 2
  %420 = getelementptr inbounds [3 x double], ptr %419, i64 0, i64 1
  %421 = load double, ptr %420, align 8, !tbaa !21
  store double %421, ptr %34, align 8, !tbaa !21
  %422 = load ptr, ptr %3, align 8, !tbaa !15
  %423 = getelementptr inbounds nuw %struct.bnode, ptr %422, i32 0, i32 2
  %424 = getelementptr inbounds [3 x double], ptr %423, i64 0, i64 2
  %425 = load double, ptr %424, align 8, !tbaa !21
  store double %425, ptr %35, align 8, !tbaa !21
  %426 = load double, ptr %33, align 8, !tbaa !21
  %427 = call i1 @llvm.is.fpclass.f64(double %426, i32 3)
  br i1 %427, label %428, label %430

428:                                              ; preds = %413
  %429 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 69)
  call void @abort() #14
  unreachable

430:                                              ; preds = %413
  %431 = load double, ptr %34, align 8, !tbaa !21
  %432 = call i1 @llvm.is.fpclass.f64(double %431, i32 3)
  br i1 %432, label %433, label %435

433:                                              ; preds = %430
  %434 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 68)
  call void @abort() #14
  unreachable

435:                                              ; preds = %430
  %436 = load double, ptr %35, align 8, !tbaa !21
  %437 = call i1 @llvm.is.fpclass.f64(double %436, i32 3)
  br i1 %437, label %438, label %440

438:                                              ; preds = %435
  %439 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 67)
  call void @abort() #14
  unreachable

440:                                              ; preds = %435
  %441 = load double, ptr %33, align 8, !tbaa !21
  %442 = call double @llvm.fabs.f64(double %441)
  %443 = fcmp olt double %442, 1.000000e+04
  br i1 %443, label %446, label %444

444:                                              ; preds = %440
  %445 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 66)
  call void @abort() #14
  unreachable

446:                                              ; preds = %440
  %447 = load double, ptr %34, align 8, !tbaa !21
  %448 = call double @llvm.fabs.f64(double %447)
  %449 = fcmp olt double %448, 1.000000e+04
  br i1 %449, label %452, label %450

450:                                              ; preds = %446
  %451 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 65)
  call void @abort() #14
  unreachable

452:                                              ; preds = %446
  %453 = load double, ptr %35, align 8, !tbaa !21
  %454 = call double @llvm.fabs.f64(double %453)
  %455 = fcmp olt double %454, 1.000000e+04
  br i1 %455, label %458, label %456

456:                                              ; preds = %452
  %457 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 64)
  call void @abort() #14
  unreachable

458:                                              ; preds = %452
  call void @llvm.lifetime.end.p0(i64 8, ptr %35) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %34) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %33) #11
  br label %459

459:                                              ; preds = %458
  %460 = load ptr, ptr %3, align 8, !tbaa !15
  %rds.field.ptr15 = getelementptr inbounds %struct.bnode, ptr %460, i32 0, i32 9
  %rds.field.val16 = load ptr, ptr %rds.field.ptr15, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val16, i32 0, i32 3, i32 1)
  %461 = getelementptr inbounds nuw %struct.bnode, ptr %460, i32 0, i32 10
  %462 = load ptr, ptr %461, align 8, !tbaa !44
  store ptr %462, ptr %3, align 8, !tbaa !15
  br label %41, !llvm.loop !81

463:                                              ; preds = %41
  call void @llvm.lifetime.end.p0(i64 24, ptr %10) #11
  call void @llvm.lifetime.end.p0(i64 24, ptr %9) #11
  call void @llvm.lifetime.end.p0(i64 24, ptr %8) #11
  call void @llvm.lifetime.end.p0(i64 24, ptr %7) #11
  call void @llvm.lifetime.end.p0(i64 24, ptr %6) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %5) #11
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.is.fpclass.f64(double, i32 immarg) #7

; Function Attrs: noreturn nounwind
declare void @abort() #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fabs.f64(double) #7

; Function Attrs: nounwind uwtable
define dso_local void @grav(double noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3, double noundef %4) #0 {
  %6 = alloca double, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca double, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca ptr, align 8
  store double %0, ptr %6, align 8, !tbaa !21
  store ptr %1, ptr %7, align 8, !tbaa !65
  store ptr %2, ptr %8, align 8, !tbaa !15
  store i32 %3, ptr %9, align 4, !tbaa !5
  store double %4, ptr %10, align 8, !tbaa !21
  call void @llvm.lifetime.start.p0(i64 8, ptr %11) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %12) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %13) #11
  store i32 0, ptr %13, align 4, !tbaa !5
  %15 = load ptr, ptr %8, align 8, !tbaa !15
  %16 = icmp ne ptr %15, null
  br i1 %16, label %17, label %19

17:                                               ; preds = %5
  call void @llvm.lifetime.start.p0(i64 8, ptr %14) #11
  %18 = load ptr, ptr %8, align 8, !tbaa !15
  store ptr %18, ptr %14, align 8, !tbaa !15
  call void @llvm.lifetime.end.p0(i64 8, ptr %14) #11
  br label %19

19:                                               ; preds = %17, %5
  %20 = load ptr, ptr %8, align 8, !tbaa !15
  store ptr %20, ptr %12, align 8, !tbaa !15
  br label %21

21:                                               ; preds = %24, %19
  %22 = load ptr, ptr %12, align 8, !tbaa !15
  %23 = icmp ne ptr %22, null
  br i1 %23, label %24, label %35

24:                                               ; preds = %21
  %25 = load double, ptr %6, align 8, !tbaa !21
  %26 = load ptr, ptr %7, align 8, !tbaa !65
  %27 = load ptr, ptr %12, align 8, !tbaa !15
  %28 = load i32, ptr %9, align 4, !tbaa !5
  %29 = load double, ptr %10, align 8, !tbaa !21
  call void @gravstep(double noundef %25, ptr noundef %26, ptr noundef %27, i32 noundef %28, double noundef %29)
  %30 = load ptr, ptr %12, align 8, !tbaa !15
  %rds.field.ptr = getelementptr inbounds %struct.bnode, ptr %30, i32 0, i32 9
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %31 = getelementptr inbounds nuw %struct.bnode, ptr %30, i32 0, i32 10
  %32 = load ptr, ptr %31, align 8, !tbaa !44
  store ptr %32, ptr %12, align 8, !tbaa !15
  %33 = load i32, ptr %13, align 4, !tbaa !5
  %34 = add nsw i32 %33, 1
  store i32 %34, ptr %13, align 4, !tbaa !5
  br label %21, !llvm.loop !82

35:                                               ; preds = %21
  call void @llvm.lifetime.end.p0(i64 4, ptr %13) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %12) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %11) #11
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @gravstep(double noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3, double noundef %4) #0 {
  %6 = alloca double, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca double, align 8
  store double %0, ptr %6, align 8, !tbaa !21
  store ptr %1, ptr %7, align 8, !tbaa !65
  store ptr %2, ptr %8, align 8, !tbaa !15
  store i32 %3, ptr %9, align 4, !tbaa !5
  store double %4, ptr %10, align 8, !tbaa !21
  %11 = load ptr, ptr %8, align 8, !tbaa !15
  %12 = load double, ptr %6, align 8, !tbaa !21
  %13 = load ptr, ptr %7, align 8, !tbaa !65
  call void @hackgrav(ptr noundef %11, double noundef %12, ptr noundef %13)
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @hackgrav(ptr noundef %0, double noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca double, align 8
  %6 = alloca ptr, align 8
  %7 = alloca %struct.hgstruct, align 8
  %8 = alloca double, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.hgstruct, align 8
  %12 = alloca i32, align 4
  store ptr %0, ptr %4, align 8, !tbaa !15
  store double %1, ptr %5, align 8, !tbaa !21
  store ptr %2, ptr %6, align 8, !tbaa !65
  call void @llvm.lifetime.start.p0(i64 64, ptr %7) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %8) #11
  %13 = load ptr, ptr %4, align 8, !tbaa !15
  %14 = getelementptr inbounds nuw %struct.hgstruct, ptr %7, i32 0, i32 0
  store ptr %13, ptr %14, align 8, !tbaa !83
  call void @llvm.lifetime.start.p0(i64 4, ptr %9) #11
  store i32 0, ptr %9, align 4, !tbaa !5
  br label %15

15:                                               ; preds = %29, %3
  %16 = load i32, ptr %9, align 4, !tbaa !5
  %17 = icmp slt i32 %16, 3
  br i1 %17, label %18, label %32

18:                                               ; preds = %15
  %19 = load ptr, ptr %4, align 8, !tbaa !15
  %rds.field.ptr3 = getelementptr inbounds %struct.bnode, ptr %19, i32 0, i32 9
  %rds.field.val4 = load ptr, ptr %rds.field.ptr3, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val4, i32 0, i32 3, i32 1)
  %rds.field.ptr5 = getelementptr inbounds %struct.bnode, ptr %19, i32 0, i32 10
  %rds.field.val6 = load ptr, ptr %rds.field.ptr5, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val6, i32 0, i32 3, i32 1)
  %20 = getelementptr inbounds nuw %struct.bnode, ptr %19, i32 0, i32 2
  %21 = load i32, ptr %9, align 4, !tbaa !5
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [3 x double], ptr %20, i64 0, i64 %22
  %24 = load double, ptr %23, align 8, !tbaa !21
  %25 = getelementptr inbounds nuw %struct.hgstruct, ptr %7, i32 0, i32 1
  %26 = load i32, ptr %9, align 4, !tbaa !5
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [3 x double], ptr %25, i64 0, i64 %27
  store double %24, ptr %28, align 8, !tbaa !21
  br label %29

29:                                               ; preds = %18
  %30 = load i32, ptr %9, align 4, !tbaa !5
  %31 = add nsw i32 %30, 1
  store i32 %31, ptr %9, align 4, !tbaa !5
  br label %15, !llvm.loop !85

32:                                               ; preds = %15
  call void @llvm.lifetime.end.p0(i64 4, ptr %9) #11
  %33 = getelementptr inbounds nuw %struct.hgstruct, ptr %7, i32 0, i32 2
  store double 0.000000e+00, ptr %33, align 8, !tbaa !86
  call void @llvm.lifetime.start.p0(i64 4, ptr %10) #11
  store i32 0, ptr %10, align 4, !tbaa !5
  br label %34

34:                                               ; preds = %42, %32
  %35 = load i32, ptr %10, align 4, !tbaa !5
  %36 = icmp slt i32 %35, 3
  br i1 %36, label %37, label %45

37:                                               ; preds = %34
  %38 = getelementptr inbounds nuw %struct.hgstruct, ptr %7, i32 0, i32 3
  %39 = load i32, ptr %10, align 4, !tbaa !5
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [3 x double], ptr %38, i64 0, i64 %40
  store double 0.000000e+00, ptr %41, align 8, !tbaa !21
  br label %42

42:                                               ; preds = %37
  %43 = load i32, ptr %10, align 4, !tbaa !5
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %10, align 4, !tbaa !5
  br label %34, !llvm.loop !87

45:                                               ; preds = %34
  call void @llvm.lifetime.end.p0(i64 4, ptr %10) #11
  %46 = load double, ptr %5, align 8, !tbaa !21
  %47 = load double, ptr %5, align 8, !tbaa !21
  %48 = fmul double %46, %47
  store double %48, ptr %8, align 8, !tbaa !21
  call void @llvm.lifetime.start.p0(i64 64, ptr %11) #11
  %49 = load ptr, ptr %6, align 8, !tbaa !65
  %50 = load double, ptr %8, align 8, !tbaa !21
  call void @walksub(ptr dead_on_unwind writable sret(%struct.hgstruct) align 8 %11, ptr noundef %49, double noundef %50, double noundef 1.000000e+00, ptr noundef byval(%struct.hgstruct) align 8 %7, i32 noundef 0)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %7, ptr align 8 %11, i64 64, i1 false), !tbaa.struct !88
  call void @llvm.lifetime.end.p0(i64 64, ptr %11) #11
  %51 = getelementptr inbounds nuw %struct.hgstruct, ptr %7, i32 0, i32 2
  %52 = load double, ptr %51, align 8, !tbaa !86
  %53 = load ptr, ptr %4, align 8, !tbaa !15
  %54 = getelementptr inbounds nuw %struct.bnode, ptr %53, i32 0, i32 8
  store double %52, ptr %54, align 8, !tbaa !89
  call void @llvm.lifetime.start.p0(i64 4, ptr %12) #11
  store i32 0, ptr %12, align 4, !tbaa !5
  br label %55

55:                                               ; preds = %69, %45
  %56 = load i32, ptr %12, align 4, !tbaa !5
  %57 = icmp slt i32 %56, 3
  br i1 %57, label %58, label %72

58:                                               ; preds = %55
  %59 = getelementptr inbounds nuw %struct.hgstruct, ptr %7, i32 0, i32 3
  %60 = load i32, ptr %12, align 4, !tbaa !5
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds [3 x double], ptr %59, i64 0, i64 %61
  %63 = load double, ptr %62, align 8, !tbaa !21
  %64 = load ptr, ptr %4, align 8, !tbaa !15
  %rds.field.ptr = getelementptr inbounds %struct.bnode, ptr %64, i32 0, i32 9
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %rds.field.ptr1 = getelementptr inbounds %struct.bnode, ptr %64, i32 0, i32 10
  %rds.field.val2 = load ptr, ptr %rds.field.ptr1, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val2, i32 0, i32 3, i32 1)
  %65 = getelementptr inbounds nuw %struct.bnode, ptr %64, i32 0, i32 7
  %66 = load i32, ptr %12, align 4, !tbaa !5
  %67 = sext i32 %66 to i64
  %68 = getelementptr inbounds [3 x double], ptr %65, i64 0, i64 %67
  store double %63, ptr %68, align 8, !tbaa !21
  br label %69

69:                                               ; preds = %58
  %70 = load i32, ptr %12, align 4, !tbaa !5
  %71 = add nsw i32 %70, 1
  store i32 %71, ptr %12, align 4, !tbaa !5
  br label %55, !llvm.loop !90

72:                                               ; preds = %55
  call void @llvm.lifetime.end.p0(i64 4, ptr %12) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %8) #11
  call void @llvm.lifetime.end.p0(i64 64, ptr %7) #11
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @expandbox(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca %struct.icstruct, align 4
  %10 = alloca i32, align 4
  %11 = alloca [3 x double], align 16
  %12 = alloca ptr, align 8
  %13 = alloca %struct.tree, align 8
  %14 = alloca double, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca double, align 8
  %18 = alloca i32, align 4
  %19 = alloca %struct.icstruct, align 4
  store ptr %0, ptr %5, align 8, !tbaa !15
  store ptr %1, ptr %6, align 8, !tbaa !14
  store i32 %2, ptr %7, align 4, !tbaa !5
  store i32 %3, ptr %8, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 16, ptr %9) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %10) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %11) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %12) #11
  call void @llvm.lifetime.start.p0(i64 1064, ptr %13) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %14) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %15) #11
  %20 = load ptr, ptr %5, align 8, !tbaa !15
  %21 = load ptr, ptr %6, align 8, !tbaa !14
  %22 = call i32 @ic_test(ptr noundef %20, ptr noundef %21)
  store i32 %22, ptr %15, align 4, !tbaa !5
  br label %23

23:                                               ; preds = %140, %4
  %24 = load i32, ptr %15, align 4, !tbaa !5
  %25 = icmp ne i32 %24, 0
  %26 = xor i1 %25, true
  br i1 %26, label %27, label %141

27:                                               ; preds = %23
  %28 = load ptr, ptr %6, align 8, !tbaa !14
  %rds.field.ptr = getelementptr inbounds %struct.tree, ptr %28, i32 0, i32 2
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %rds.field.ptr1 = getelementptr inbounds %struct.tree, ptr %28, i32 0, i32 3
  %rds.field.val2 = load ptr, ptr %rds.field.ptr1, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val2, i32 0, i32 3, i32 1)
  %rds.field.ptr3 = getelementptr inbounds %struct.tree, ptr %28, i32 0, i32 4
  %rds.field.val4 = load ptr, ptr %rds.field.ptr3, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val4, i32 0, i32 3, i32 1)
  %29 = getelementptr inbounds nuw %struct.tree, ptr %28, i32 0, i32 1
  %30 = load double, ptr %29, align 8, !tbaa !22
  store double %30, ptr %14, align 8, !tbaa !21
  %31 = load double, ptr %14, align 8, !tbaa !21
  %32 = fcmp olt double %31, 1.000000e+03
  br i1 %32, label %35, label %33

33:                                               ; preds = %27
  %34 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 999)
  call void @abort() #14
  unreachable

35:                                               ; preds = %27
  call void @llvm.lifetime.start.p0(i64 4, ptr %16) #11
  store i32 0, ptr %16, align 4, !tbaa !5
  br label %36

36:                                               ; preds = %51, %35
  %37 = load i32, ptr %16, align 4, !tbaa !5
  %38 = icmp slt i32 %37, 3
  br i1 %38, label %39, label %54

39:                                               ; preds = %36
  %40 = load ptr, ptr %6, align 8, !tbaa !14
  %rds.field.ptr25 = getelementptr inbounds %struct.tree, ptr %40, i32 0, i32 2
  %rds.field.val26 = load ptr, ptr %rds.field.ptr25, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val26, i32 0, i32 3, i32 1)
  %rds.field.ptr27 = getelementptr inbounds %struct.tree, ptr %40, i32 0, i32 3
  %rds.field.val28 = load ptr, ptr %rds.field.ptr27, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val28, i32 0, i32 3, i32 1)
  %rds.field.ptr29 = getelementptr inbounds %struct.tree, ptr %40, i32 0, i32 4
  %rds.field.val30 = load ptr, ptr %rds.field.ptr29, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val30, i32 0, i32 3, i32 1)
  %41 = getelementptr inbounds nuw %struct.tree, ptr %40, i32 0, i32 0
  %42 = load i32, ptr %16, align 4, !tbaa !5
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [3 x double], ptr %41, i64 0, i64 %43
  %45 = load double, ptr %44, align 8, !tbaa !21
  %46 = load double, ptr %14, align 8, !tbaa !21
  %47 = call double @llvm.fmuladd.f64(double 5.000000e-01, double %46, double %45)
  %48 = load i32, ptr %16, align 4, !tbaa !5
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [3 x double], ptr %11, i64 0, i64 %49
  store double %47, ptr %50, align 8, !tbaa !21
  br label %51

51:                                               ; preds = %39
  %52 = load i32, ptr %16, align 4, !tbaa !5
  %53 = add nsw i32 %52, 1
  store i32 %53, ptr %16, align 4, !tbaa !5
  br label %36, !llvm.loop !91

54:                                               ; preds = %36
  call void @llvm.lifetime.end.p0(i64 4, ptr %16) #11
  store i32 0, ptr %10, align 4, !tbaa !5
  br label %55

55:                                               ; preds = %86, %54
  %56 = load i32, ptr %10, align 4, !tbaa !5
  %57 = icmp slt i32 %56, 3
  br i1 %57, label %58, label %89

58:                                               ; preds = %55
  %59 = load ptr, ptr %5, align 8, !tbaa !15
  %rds.field.ptr15 = getelementptr inbounds %struct.bnode, ptr %59, i32 0, i32 9
  %rds.field.val16 = load ptr, ptr %rds.field.ptr15, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val16, i32 0, i32 3, i32 1)
  %rds.field.ptr17 = getelementptr inbounds %struct.bnode, ptr %59, i32 0, i32 10
  %rds.field.val18 = load ptr, ptr %rds.field.ptr17, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val18, i32 0, i32 3, i32 1)
  %60 = getelementptr inbounds nuw %struct.bnode, ptr %59, i32 0, i32 2
  %61 = load i32, ptr %10, align 4, !tbaa !5
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds [3 x double], ptr %60, i64 0, i64 %62
  %64 = load double, ptr %63, align 8, !tbaa !21
  %65 = load i32, ptr %10, align 4, !tbaa !5
  %66 = sext i32 %65 to i64
  %67 = getelementptr inbounds [3 x double], ptr %11, i64 0, i64 %66
  %68 = load double, ptr %67, align 8, !tbaa !21
  %69 = fcmp olt double %64, %68
  br i1 %69, label %70, label %85

70:                                               ; preds = %58
  call void @llvm.lifetime.start.p0(i64 8, ptr %17) #11
  %71 = load ptr, ptr %6, align 8, !tbaa !14
  %rds.field.ptr19 = getelementptr inbounds %struct.tree, ptr %71, i32 0, i32 2
  %rds.field.val20 = load ptr, ptr %rds.field.ptr19, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val20, i32 0, i32 3, i32 1)
  %rds.field.ptr21 = getelementptr inbounds %struct.tree, ptr %71, i32 0, i32 3
  %rds.field.val22 = load ptr, ptr %rds.field.ptr21, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val22, i32 0, i32 3, i32 1)
  %rds.field.ptr23 = getelementptr inbounds %struct.tree, ptr %71, i32 0, i32 4
  %rds.field.val24 = load ptr, ptr %rds.field.ptr23, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val24, i32 0, i32 3, i32 1)
  %72 = getelementptr inbounds nuw %struct.tree, ptr %71, i32 0, i32 0
  %73 = load i32, ptr %10, align 4, !tbaa !5
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds [3 x double], ptr %72, i64 0, i64 %74
  %76 = load double, ptr %75, align 8, !tbaa !21
  store double %76, ptr %17, align 8, !tbaa !21
  %77 = load double, ptr %17, align 8, !tbaa !21
  %78 = load double, ptr %14, align 8, !tbaa !21
  %79 = fsub double %77, %78
  %80 = load ptr, ptr %6, align 8, !tbaa !14
  %81 = getelementptr inbounds nuw %struct.tree, ptr %80, i32 0, i32 0
  %82 = load i32, ptr %10, align 4, !tbaa !5
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds [3 x double], ptr %81, i64 0, i64 %83
  store double %79, ptr %84, align 8, !tbaa !21
  call void @llvm.lifetime.end.p0(i64 8, ptr %17) #11
  br label %85

85:                                               ; preds = %70, %58
  br label %86

86:                                               ; preds = %85
  %87 = load i32, ptr %10, align 4, !tbaa !5
  %88 = add nsw i32 %87, 1
  store i32 %88, ptr %10, align 4, !tbaa !5
  br label %55, !llvm.loop !92

89:                                               ; preds = %55
  %90 = load double, ptr %14, align 8, !tbaa !21
  %91 = fmul double 2.000000e+00, %90
  %92 = load ptr, ptr %6, align 8, !tbaa !14
  %rds.field.ptr5 = getelementptr inbounds %struct.tree, ptr %92, i32 0, i32 2
  %rds.field.val6 = load ptr, ptr %rds.field.ptr5, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val6, i32 0, i32 3, i32 1)
  %rds.field.ptr7 = getelementptr inbounds %struct.tree, ptr %92, i32 0, i32 3
  %rds.field.val8 = load ptr, ptr %rds.field.ptr7, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val8, i32 0, i32 3, i32 1)
  %rds.field.ptr9 = getelementptr inbounds %struct.tree, ptr %92, i32 0, i32 4
  %rds.field.val10 = load ptr, ptr %rds.field.ptr9, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val10, i32 0, i32 3, i32 1)
  %93 = getelementptr inbounds nuw %struct.tree, ptr %92, i32 0, i32 1
  store double %91, ptr %93, align 8, !tbaa !22
  %94 = load ptr, ptr %6, align 8, !tbaa !14
  %95 = getelementptr inbounds nuw %struct.tree, ptr %94, i32 0, i32 1
  %96 = load double, ptr %95, align 8, !tbaa !22
  store double %96, ptr %14, align 8, !tbaa !21
  %97 = load ptr, ptr %6, align 8, !tbaa !14
  %98 = getelementptr inbounds nuw %struct.tree, ptr %97, i32 0, i32 2
  %99 = load ptr, ptr %98, align 8, !tbaa !17
  %100 = icmp ne ptr %99, null
  br i1 %100, label %101, label %140

101:                                              ; preds = %89
  call void @llvm.lifetime.start.p0(i64 4, ptr %18) #11
  %102 = call ptr @cell_alloc(i32 noundef 0)
  store ptr %102, ptr %12, align 8, !tbaa !93
  call void @llvm.lifetime.start.p0(i64 16, ptr %19) #11
  %103 = getelementptr inbounds [3 x double], ptr %11, i64 0, i64 0
  %104 = load double, ptr %103, align 16, !tbaa !21
  %105 = getelementptr inbounds [3 x double], ptr %11, i64 0, i64 1
  %106 = load double, ptr %105, align 8, !tbaa !21
  %107 = getelementptr inbounds [3 x double], ptr %11, i64 0, i64 2
  %108 = load double, ptr %107, align 16, !tbaa !21
  %109 = load ptr, ptr %6, align 8, !tbaa !14
  %110 = call { i64, i64 } @intcoord1(double noundef %104, double noundef %106, double noundef %108, ptr noundef %109)
  %111 = getelementptr inbounds nuw { i64, i64 }, ptr %19, i32 0, i32 0
  %112 = extractvalue { i64, i64 } %110, 0
  store i64 %112, ptr %111, align 4
  %113 = getelementptr inbounds nuw { i64, i64 }, ptr %19, i32 0, i32 1
  %114 = extractvalue { i64, i64 } %110, 1
  store i64 %114, ptr %113, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %9, ptr align 4 %19, i64 16, i1 false), !tbaa.struct !42
  call void @llvm.lifetime.end.p0(i64 16, ptr %19) #11
  %115 = getelementptr inbounds nuw %struct.icstruct, ptr %9, i32 0, i32 1
  %116 = load i16, ptr %115, align 4, !tbaa !62
  %117 = icmp ne i16 %116, 0
  br i1 %117, label %120, label %118

118:                                              ; preds = %101
  %119 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 1)
  call void @abort() #14
  unreachable

120:                                              ; preds = %101
  %121 = getelementptr inbounds nuw { i64, i64 }, ptr %9, i32 0, i32 0
  %122 = load i64, ptr %121, align 4
  %123 = getelementptr inbounds nuw { i64, i64 }, ptr %9, i32 0, i32 1
  %124 = load i64, ptr %123, align 4
  %125 = call i32 @old_subindex(i64 %122, i64 %124, i32 noundef 536870912)
  store i32 %125, ptr %10, align 4, !tbaa !5
  %126 = load ptr, ptr %6, align 8, !tbaa !14
  %rds.field.ptr11 = getelementptr inbounds %struct.tree, ptr %126, i32 0, i32 3
  %rds.field.val12 = load ptr, ptr %rds.field.ptr11, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val12, i32 0, i32 3, i32 1)
  %rds.field.ptr13 = getelementptr inbounds %struct.tree, ptr %126, i32 0, i32 4
  %rds.field.val14 = load ptr, ptr %rds.field.ptr13, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val14, i32 0, i32 3, i32 1)
  %127 = getelementptr inbounds nuw %struct.tree, ptr %126, i32 0, i32 2
  %128 = load ptr, ptr %127, align 8, !tbaa !17
  %129 = load ptr, ptr %12, align 8, !tbaa !93
  %130 = getelementptr inbounds nuw %struct.cnode, ptr %129, i32 0, i32 5
  %131 = load i32, ptr %10, align 4, !tbaa !5
  %132 = sext i32 %131 to i64
  %133 = getelementptr inbounds [8 x ptr], ptr %130, i64 0, i64 %132
  store ptr %128, ptr %133, align 8, !tbaa !65
  %134 = load ptr, ptr %12, align 8, !tbaa !93
  %135 = load ptr, ptr %6, align 8, !tbaa !14
  %136 = getelementptr inbounds nuw %struct.tree, ptr %135, i32 0, i32 2
  store ptr %134, ptr %136, align 8, !tbaa !17
  %137 = load ptr, ptr %5, align 8, !tbaa !15
  %138 = load ptr, ptr %6, align 8, !tbaa !14
  %139 = call i32 @ic_test(ptr noundef %137, ptr noundef %138)
  store i32 %139, ptr %15, align 4, !tbaa !5
  call void @llvm.lifetime.end.p0(i64 4, ptr %18) #11
  br label %140

140:                                              ; preds = %120, %89
  br label %23, !llvm.loop !95

141:                                              ; preds = %23
  call void @llvm.lifetime.end.p0(i64 4, ptr %15) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %14) #11
  call void @llvm.lifetime.end.p0(i64 1064, ptr %13) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %12) #11
  call void @llvm.lifetime.end.p0(i64 24, ptr %11) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %10) #11
  call void @llvm.lifetime.end.p0(i64 16, ptr %9) #11
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local ptr @loadtree(ptr noundef %0, i64 %1, i64 %2, ptr noundef %3, i32 noundef %4, ptr noundef %5) #0 {
  %7 = alloca ptr, align 8
  %8 = alloca %struct.icstruct, align 4
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca ptr, align 8
  %15 = alloca ptr, align 8
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca %struct.icstruct, align 4
  %20 = alloca %struct.icstruct, align 4
  %21 = getelementptr inbounds nuw { i64, i64 }, ptr %8, i32 0, i32 0
  store i64 %1, ptr %21, align 4
  %22 = getelementptr inbounds nuw { i64, i64 }, ptr %8, i32 0, i32 1
  store i64 %2, ptr %22, align 4
  store ptr %0, ptr %9, align 8, !tbaa !15
  store ptr %3, ptr %10, align 8, !tbaa !65
  store i32 %4, ptr %11, align 4, !tbaa !5
  store ptr %5, ptr %12, align 8, !tbaa !14
  call void @llvm.lifetime.start.p0(i64 4, ptr %13) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %14) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %15) #11
  %23 = load ptr, ptr %10, align 8, !tbaa !65
  %24 = icmp eq ptr %23, null
  br i1 %24, label %25, label %27

25:                                               ; preds = %6
  %26 = load ptr, ptr %9, align 8, !tbaa !15
  store ptr %26, ptr %7, align 8
  store i32 1, ptr %16, align 4
  br label %82

27:                                               ; preds = %6
  %28 = load i32, ptr %11, align 4, !tbaa !5
  %29 = icmp ne i32 %28, 0
  br i1 %29, label %32, label %30

30:                                               ; preds = %27
  %31 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 2)
  call void @abort() #14
  unreachable

32:                                               ; preds = %27
  %33 = load ptr, ptr %10, align 8, !tbaa !65
  %34 = getelementptr inbounds nuw %struct.node, ptr %33, i32 0, i32 0
  %35 = load i16, ptr %34, align 8, !tbaa !96
  %36 = sext i16 %35 to i32
  %37 = icmp eq i32 %36, 1
  br i1 %37, label %38, label %52

38:                                               ; preds = %32
  call void @llvm.lifetime.start.p0(i64 4, ptr %17) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %18) #11
  call void @llvm.lifetime.start.p0(i64 16, ptr %19) #11
  call void @llvm.lifetime.start.p0(i64 16, ptr %20) #11
  store i32 0, ptr %17, align 4, !tbaa !5
  %39 = load i32, ptr %17, align 4, !tbaa !5
  %40 = call ptr @cell_alloc(i32 noundef %39)
  store ptr %40, ptr %14, align 8, !tbaa !93
  %41 = load ptr, ptr %10, align 8, !tbaa !65
  %42 = load ptr, ptr %12, align 8, !tbaa !14
  %43 = load i32, ptr %11, align 4, !tbaa !5
  %44 = call i32 @subindex(ptr noundef %41, ptr noundef %42, i32 noundef %43)
  store i32 %44, ptr %13, align 4, !tbaa !5
  %45 = load ptr, ptr %10, align 8, !tbaa !65
  %46 = load ptr, ptr %14, align 8, !tbaa !93
  %47 = getelementptr inbounds nuw %struct.cnode, ptr %46, i32 0, i32 5
  %48 = load i32, ptr %13, align 4, !tbaa !5
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [8 x ptr], ptr %47, i64 0, i64 %49
  store ptr %45, ptr %50, align 8, !tbaa !65
  %51 = load ptr, ptr %14, align 8, !tbaa !93
  store ptr %51, ptr %10, align 8, !tbaa !65
  call void @llvm.lifetime.end.p0(i64 16, ptr %20) #11
  call void @llvm.lifetime.end.p0(i64 16, ptr %19) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %18) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %17) #11
  br label %52

52:                                               ; preds = %38, %32
  %53 = load i32, ptr %11, align 4, !tbaa !5
  %54 = getelementptr inbounds nuw { i64, i64 }, ptr %8, i32 0, i32 0
  %55 = load i64, ptr %54, align 4
  %56 = getelementptr inbounds nuw { i64, i64 }, ptr %8, i32 0, i32 1
  %57 = load i64, ptr %56, align 4
  %58 = call i32 @old_subindex(i64 %55, i64 %57, i32 noundef %53)
  store i32 %58, ptr %13, align 4, !tbaa !5
  %59 = load ptr, ptr %10, align 8, !tbaa !65
  %60 = getelementptr inbounds nuw %struct.cnode, ptr %59, i32 0, i32 5
  %61 = load i32, ptr %13, align 4, !tbaa !5
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds [8 x ptr], ptr %60, i64 0, i64 %62
  %64 = load ptr, ptr %63, align 8, !tbaa !65
  store ptr %64, ptr %15, align 8, !tbaa !65
  %65 = load ptr, ptr %9, align 8, !tbaa !15
  %66 = load ptr, ptr %15, align 8, !tbaa !65
  %67 = load i32, ptr %11, align 4, !tbaa !5
  %68 = ashr i32 %67, 1
  %69 = load ptr, ptr %12, align 8, !tbaa !14
  %70 = getelementptr inbounds nuw { i64, i64 }, ptr %8, i32 0, i32 0
  %71 = load i64, ptr %70, align 4
  %72 = getelementptr inbounds nuw { i64, i64 }, ptr %8, i32 0, i32 1
  %73 = load i64, ptr %72, align 4
  %74 = call ptr @loadtree(ptr noundef %65, i64 %71, i64 %73, ptr noundef %66, i32 noundef %68, ptr noundef %69)
  %75 = load ptr, ptr %10, align 8, !tbaa !65
  %76 = getelementptr inbounds nuw %struct.cnode, ptr %75, i32 0, i32 5
  %77 = load i32, ptr %13, align 4, !tbaa !5
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds [8 x ptr], ptr %76, i64 0, i64 %78
  store ptr %74, ptr %79, align 8, !tbaa !65
  br label %80

80:                                               ; preds = %52
  %81 = load ptr, ptr %10, align 8, !tbaa !65
  store ptr %81, ptr %7, align 8
  store i32 1, ptr %16, align 4
  br label %82

82:                                               ; preds = %80, %25
  call void @llvm.lifetime.end.p0(i64 8, ptr %15) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %14) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %13) #11
  %83 = load ptr, ptr %7, align 8
  ret ptr %83
}

; Function Attrs: nounwind uwtable
define dso_local double @hackcofm(ptr noundef %0) #0 {
  %2 = alloca double, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca [3 x double], align 16
  %7 = alloca [3 x double], align 16
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  store ptr %0, ptr %3, align 8, !tbaa !65
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %5) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %6) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %7) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %8) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %9) #11
  %15 = load ptr, ptr %3, align 8, !tbaa !65
  %16 = getelementptr inbounds nuw %struct.node, ptr %15, i32 0, i32 0
  %17 = load i16, ptr %16, align 8, !tbaa !96
  %18 = sext i16 %17 to i32
  %19 = icmp eq i32 %18, 2
  br i1 %19, label %20, label %136

20:                                               ; preds = %1
  store double 0.000000e+00, ptr %8, align 8, !tbaa !21
  call void @llvm.lifetime.start.p0(i64 4, ptr %10) #11
  store i32 0, ptr %10, align 4, !tbaa !5
  br label %21

21:                                               ; preds = %28, %20
  %22 = load i32, ptr %10, align 4, !tbaa !5
  %23 = icmp slt i32 %22, 3
  br i1 %23, label %24, label %31

24:                                               ; preds = %21
  %25 = load i32, ptr %10, align 4, !tbaa !5
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [3 x double], ptr %7, i64 0, i64 %26
  store double 0.000000e+00, ptr %27, align 8, !tbaa !21
  br label %28

28:                                               ; preds = %24
  %29 = load i32, ptr %10, align 4, !tbaa !5
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr %10, align 4, !tbaa !5
  br label %21, !llvm.loop !98

31:                                               ; preds = %21
  call void @llvm.lifetime.end.p0(i64 4, ptr %10) #11
  store i32 0, ptr %4, align 4, !tbaa !5
  br label %32

32:                                               ; preds = %90, %31
  %33 = load i32, ptr %4, align 4, !tbaa !5
  %34 = icmp slt i32 %33, 8
  br i1 %34, label %35, label %93

35:                                               ; preds = %32
  %36 = load ptr, ptr %3, align 8, !tbaa !65
  %rds.field.ptr = getelementptr inbounds %struct.cnode, ptr %36, i32 0, i32 6
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %37 = getelementptr inbounds nuw %struct.cnode, ptr %36, i32 0, i32 5
  %38 = load i32, ptr %4, align 4, !tbaa !5
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [8 x ptr], ptr %37, i64 0, i64 %39
  %41 = load ptr, ptr %40, align 8, !tbaa !65
  store ptr %41, ptr %5, align 8, !tbaa !65
  %42 = load ptr, ptr %5, align 8, !tbaa !65
  %43 = icmp ne ptr %42, null
  br i1 %43, label %44, label %89

44:                                               ; preds = %35
  %45 = load ptr, ptr %5, align 8, !tbaa !65
  %46 = call double @hackcofm(ptr noundef %45)
  store double %46, ptr %9, align 8, !tbaa !21
  %47 = load double, ptr %9, align 8, !tbaa !21
  %48 = load double, ptr %8, align 8, !tbaa !21
  %49 = fadd double %47, %48
  store double %49, ptr %8, align 8, !tbaa !21
  call void @llvm.lifetime.start.p0(i64 4, ptr %11) #11
  store i32 0, ptr %11, align 4, !tbaa !5
  br label %50

50:                                               ; preds = %65, %44
  %51 = load i32, ptr %11, align 4, !tbaa !5
  %52 = icmp slt i32 %51, 3
  br i1 %52, label %53, label %68

53:                                               ; preds = %50
  %54 = load ptr, ptr %5, align 8, !tbaa !65
  %55 = getelementptr inbounds nuw %struct.node, ptr %54, i32 0, i32 2
  %56 = load i32, ptr %11, align 4, !tbaa !5
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds [3 x double], ptr %55, i64 0, i64 %57
  %59 = load double, ptr %58, align 8, !tbaa !21
  %60 = load double, ptr %9, align 8, !tbaa !21
  %61 = fmul double %59, %60
  %62 = load i32, ptr %11, align 4, !tbaa !5
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds [3 x double], ptr %6, i64 0, i64 %63
  store double %61, ptr %64, align 8, !tbaa !21
  br label %65

65:                                               ; preds = %53
  %66 = load i32, ptr %11, align 4, !tbaa !5
  %67 = add nsw i32 %66, 1
  store i32 %67, ptr %11, align 4, !tbaa !5
  br label %50, !llvm.loop !99

68:                                               ; preds = %50
  call void @llvm.lifetime.end.p0(i64 4, ptr %11) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %12) #11
  store i32 0, ptr %12, align 4, !tbaa !5
  br label %69

69:                                               ; preds = %85, %68
  %70 = load i32, ptr %12, align 4, !tbaa !5
  %71 = icmp slt i32 %70, 3
  br i1 %71, label %72, label %88

72:                                               ; preds = %69
  %73 = load i32, ptr %12, align 4, !tbaa !5
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds [3 x double], ptr %7, i64 0, i64 %74
  %76 = load double, ptr %75, align 8, !tbaa !21
  %77 = load i32, ptr %12, align 4, !tbaa !5
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds [3 x double], ptr %6, i64 0, i64 %78
  %80 = load double, ptr %79, align 8, !tbaa !21
  %81 = fadd double %76, %80
  %82 = load i32, ptr %12, align 4, !tbaa !5
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds [3 x double], ptr %7, i64 0, i64 %83
  store double %81, ptr %84, align 8, !tbaa !21
  br label %85

85:                                               ; preds = %72
  %86 = load i32, ptr %12, align 4, !tbaa !5
  %87 = add nsw i32 %86, 1
  store i32 %87, ptr %12, align 4, !tbaa !5
  br label %69, !llvm.loop !100

88:                                               ; preds = %69
  call void @llvm.lifetime.end.p0(i64 4, ptr %12) #11
  br label %89

89:                                               ; preds = %88, %35
  br label %90

90:                                               ; preds = %89
  %91 = load i32, ptr %4, align 4, !tbaa !5
  %92 = add nsw i32 %91, 1
  store i32 %92, ptr %4, align 4, !tbaa !5
  br label %32, !llvm.loop !101

93:                                               ; preds = %32
  %94 = load double, ptr %8, align 8, !tbaa !21
  %95 = load ptr, ptr %3, align 8, !tbaa !65
  %96 = getelementptr inbounds nuw %struct.node, ptr %95, i32 0, i32 1
  store double %94, ptr %96, align 8, !tbaa !102
  %97 = getelementptr inbounds [3 x double], ptr %7, i64 0, i64 0
  %98 = load double, ptr %97, align 16, !tbaa !21
  %99 = load ptr, ptr %3, align 8, !tbaa !65
  %100 = getelementptr inbounds nuw %struct.node, ptr %99, i32 0, i32 2
  %101 = getelementptr inbounds [3 x double], ptr %100, i64 0, i64 0
  store double %98, ptr %101, align 8, !tbaa !21
  %102 = getelementptr inbounds [3 x double], ptr %7, i64 0, i64 1
  %103 = load double, ptr %102, align 8, !tbaa !21
  %104 = load ptr, ptr %3, align 8, !tbaa !65
  %105 = getelementptr inbounds nuw %struct.node, ptr %104, i32 0, i32 2
  %106 = getelementptr inbounds [3 x double], ptr %105, i64 0, i64 1
  store double %103, ptr %106, align 8, !tbaa !21
  %107 = getelementptr inbounds [3 x double], ptr %7, i64 0, i64 2
  %108 = load double, ptr %107, align 16, !tbaa !21
  %109 = load ptr, ptr %3, align 8, !tbaa !65
  %110 = getelementptr inbounds nuw %struct.node, ptr %109, i32 0, i32 2
  %111 = getelementptr inbounds [3 x double], ptr %110, i64 0, i64 2
  store double %108, ptr %111, align 8, !tbaa !21
  call void @llvm.lifetime.start.p0(i64 4, ptr %13) #11
  store i32 0, ptr %13, align 4, !tbaa !5
  br label %112

112:                                              ; preds = %131, %93
  %113 = load i32, ptr %13, align 4, !tbaa !5
  %114 = icmp slt i32 %113, 3
  br i1 %114, label %115, label %134

115:                                              ; preds = %112
  %116 = load ptr, ptr %3, align 8, !tbaa !65
  %117 = getelementptr inbounds nuw %struct.node, ptr %116, i32 0, i32 2
  %118 = load i32, ptr %13, align 4, !tbaa !5
  %119 = sext i32 %118 to i64
  %120 = getelementptr inbounds [3 x double], ptr %117, i64 0, i64 %119
  %121 = load double, ptr %120, align 8, !tbaa !21
  %122 = load ptr, ptr %3, align 8, !tbaa !65
  %123 = getelementptr inbounds nuw %struct.node, ptr %122, i32 0, i32 1
  %124 = load double, ptr %123, align 8, !tbaa !102
  %125 = fdiv double %121, %124
  %126 = load ptr, ptr %3, align 8, !tbaa !65
  %127 = getelementptr inbounds nuw %struct.node, ptr %126, i32 0, i32 2
  %128 = load i32, ptr %13, align 4, !tbaa !5
  %129 = sext i32 %128 to i64
  %130 = getelementptr inbounds [3 x double], ptr %127, i64 0, i64 %129
  store double %125, ptr %130, align 8, !tbaa !21
  br label %131

131:                                              ; preds = %115
  %132 = load i32, ptr %13, align 4, !tbaa !5
  %133 = add nsw i32 %132, 1
  store i32 %133, ptr %13, align 4, !tbaa !5
  br label %112, !llvm.loop !103

134:                                              ; preds = %112
  call void @llvm.lifetime.end.p0(i64 4, ptr %13) #11
  %135 = load double, ptr %8, align 8, !tbaa !21
  store double %135, ptr %2, align 8
  store i32 1, ptr %14, align 4
  br label %141

136:                                              ; preds = %1
  %137 = load ptr, ptr %3, align 8, !tbaa !65
  %138 = getelementptr inbounds nuw %struct.node, ptr %137, i32 0, i32 1
  %139 = load double, ptr %138, align 8, !tbaa !102
  store double %139, ptr %8, align 8, !tbaa !21
  %140 = load double, ptr %8, align 8, !tbaa !21
  store double %140, ptr %2, align 8
  store i32 1, ptr %14, align 4
  br label %141

141:                                              ; preds = %136, %134
  call void @llvm.lifetime.end.p0(i64 8, ptr %9) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %8) #11
  call void @llvm.lifetime.end.p0(i64 24, ptr %7) #11
  call void @llvm.lifetime.end.p0(i64 24, ptr %6) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %5) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #11
  %142 = load double, ptr %2, align 8
  ret double %142
}

; Function Attrs: nounwind uwtable
define dso_local ptr @cell_alloc(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store i32 %0, ptr %2, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 8, ptr %3) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #11
  %5 = load ptr, ptr @cp_free_list, align 8, !tbaa !65
  %6 = icmp ne ptr %5, null
  br i1 %6, label %7, label %12

7:                                                ; preds = %1
  %8 = load ptr, ptr @cp_free_list, align 8, !tbaa !65
  store ptr %8, ptr %3, align 8, !tbaa !93
  %9 = load ptr, ptr @cp_free_list, align 8, !tbaa !65
  %10 = getelementptr inbounds nuw %struct.cnode, ptr %9, i32 0, i32 6
  %11 = load ptr, ptr %10, align 8, !tbaa !104
  store ptr %11, ptr @cp_free_list, align 8, !tbaa !65
  br label %14

12:                                               ; preds = %1
  %13 = call noalias ptr @malloc(i64 noundef 120) #13
  store ptr %13, ptr %3, align 8, !tbaa !93
  br label %14

14:                                               ; preds = %12, %7
  %15 = load ptr, ptr %3, align 8, !tbaa !93
  %16 = getelementptr inbounds nuw %struct.cnode, ptr %15, i32 0, i32 0
  store i16 2, ptr %16, align 8, !tbaa !106
  %17 = load i32, ptr %2, align 4, !tbaa !5
  %18 = load ptr, ptr %3, align 8, !tbaa !93
  %19 = getelementptr inbounds nuw %struct.cnode, ptr %18, i32 0, i32 3
  store i32 %17, ptr %19, align 8, !tbaa !107
  store i32 0, ptr %4, align 4, !tbaa !5
  br label %20

20:                                               ; preds = %29, %14
  %21 = load i32, ptr %4, align 4, !tbaa !5
  %22 = icmp slt i32 %21, 8
  br i1 %22, label %23, label %32

23:                                               ; preds = %20
  %24 = load ptr, ptr %3, align 8, !tbaa !93
  %rds.field.ptr = getelementptr inbounds %struct.cnode, ptr %24, i32 0, i32 6
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %25 = getelementptr inbounds nuw %struct.cnode, ptr %24, i32 0, i32 5
  %26 = load i32, ptr %4, align 4, !tbaa !5
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [8 x ptr], ptr %25, i64 0, i64 %27
  store ptr null, ptr %28, align 8, !tbaa !65
  br label %29

29:                                               ; preds = %23
  %30 = load i32, ptr %4, align 4, !tbaa !5
  %31 = add nsw i32 %30, 1
  store i32 %31, ptr %4, align 4, !tbaa !5
  br label %20, !llvm.loop !108

32:                                               ; preds = %20
  %33 = load ptr, ptr %3, align 8, !tbaa !93
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %3) #11
  ret ptr %33
}

; Function Attrs: nounwind uwtable
define dso_local i32 @subindex(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca double, align 8
  %10 = alloca double, align 8
  %11 = alloca [3 x i32], align 4
  %12 = alloca [3 x double], align 16
  store ptr %0, ptr %4, align 8, !tbaa !15
  store ptr %1, ptr %5, align 8, !tbaa !14
  store i32 %2, ptr %6, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 4, ptr %7) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %8) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %9) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %10) #11
  call void @llvm.lifetime.start.p0(i64 12, ptr %11) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %12) #11
  %13 = load ptr, ptr %4, align 8, !tbaa !15
  %14 = getelementptr inbounds nuw %struct.bnode, ptr %13, i32 0, i32 2
  %15 = getelementptr inbounds [3 x double], ptr %14, i64 0, i64 0
  %16 = load double, ptr %15, align 8, !tbaa !21
  %17 = getelementptr inbounds [3 x double], ptr %12, i64 0, i64 0
  store double %16, ptr %17, align 16, !tbaa !21
  %18 = load ptr, ptr %4, align 8, !tbaa !15
  %19 = getelementptr inbounds nuw %struct.bnode, ptr %18, i32 0, i32 2
  %20 = getelementptr inbounds [3 x double], ptr %19, i64 0, i64 1
  %21 = load double, ptr %20, align 8, !tbaa !21
  %22 = getelementptr inbounds [3 x double], ptr %12, i64 0, i64 1
  store double %21, ptr %22, align 8, !tbaa !21
  %23 = load ptr, ptr %4, align 8, !tbaa !15
  %24 = getelementptr inbounds nuw %struct.bnode, ptr %23, i32 0, i32 2
  %25 = getelementptr inbounds [3 x double], ptr %24, i64 0, i64 2
  %26 = load double, ptr %25, align 8, !tbaa !21
  %27 = getelementptr inbounds [3 x double], ptr %12, i64 0, i64 2
  store double %26, ptr %27, align 16, !tbaa !21
  %28 = load ptr, ptr %5, align 8, !tbaa !14
  %29 = getelementptr inbounds nuw %struct.tree, ptr %28, i32 0, i32 1
  %30 = load double, ptr %29, align 8, !tbaa !22
  store double %30, ptr %9, align 8, !tbaa !21
  %31 = getelementptr inbounds [3 x double], ptr %12, i64 0, i64 0
  %32 = load double, ptr %31, align 16, !tbaa !21
  %33 = load ptr, ptr %5, align 8, !tbaa !14
  %34 = getelementptr inbounds nuw %struct.tree, ptr %33, i32 0, i32 0
  %35 = getelementptr inbounds [3 x double], ptr %34, i64 0, i64 0
  %36 = load double, ptr %35, align 8, !tbaa !21
  %37 = fsub double %32, %36
  %38 = load double, ptr %9, align 8, !tbaa !21
  %39 = fdiv double %37, %38
  store double %39, ptr %10, align 8, !tbaa !21
  %40 = load double, ptr %10, align 8, !tbaa !21
  %41 = fcmp ole double 0.000000e+00, %40
  br i1 %41, label %42, label %45

42:                                               ; preds = %3
  %43 = load double, ptr %10, align 8, !tbaa !21
  %44 = fcmp olt double %43, 1.000000e+00
  br i1 %44, label %47, label %45

45:                                               ; preds = %42, %3
  %46 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 5)
  call void @abort() #14
  unreachable

47:                                               ; preds = %42
  %48 = load double, ptr %10, align 8, !tbaa !21
  %49 = fmul double 0x41D0000000000000, %48
  %50 = call double @llvm.floor.f64(double %49)
  %51 = fptosi double %50 to i32
  %52 = getelementptr inbounds [3 x i32], ptr %11, i64 0, i64 0
  store i32 %51, ptr %52, align 4, !tbaa !5
  %53 = getelementptr inbounds [3 x double], ptr %12, i64 0, i64 1
  %54 = load double, ptr %53, align 8, !tbaa !21
  %55 = load ptr, ptr %5, align 8, !tbaa !14
  %56 = getelementptr inbounds nuw %struct.tree, ptr %55, i32 0, i32 0
  %57 = getelementptr inbounds [3 x double], ptr %56, i64 0, i64 1
  %58 = load double, ptr %57, align 8, !tbaa !21
  %59 = fsub double %54, %58
  %60 = load double, ptr %9, align 8, !tbaa !21
  %61 = fdiv double %59, %60
  store double %61, ptr %10, align 8, !tbaa !21
  %62 = load double, ptr %10, align 8, !tbaa !21
  %63 = fcmp ole double 0.000000e+00, %62
  br i1 %63, label %64, label %67

64:                                               ; preds = %47
  %65 = load double, ptr %10, align 8, !tbaa !21
  %66 = fcmp olt double %65, 1.000000e+00
  br i1 %66, label %69, label %67

67:                                               ; preds = %64, %47
  %68 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 6)
  call void @abort() #14
  unreachable

69:                                               ; preds = %64
  %70 = load double, ptr %10, align 8, !tbaa !21
  %71 = fmul double 0x41D0000000000000, %70
  %72 = call double @llvm.floor.f64(double %71)
  %73 = fptosi double %72 to i32
  %74 = getelementptr inbounds [3 x i32], ptr %11, i64 0, i64 1
  store i32 %73, ptr %74, align 4, !tbaa !5
  %75 = getelementptr inbounds [3 x double], ptr %12, i64 0, i64 2
  %76 = load double, ptr %75, align 16, !tbaa !21
  %77 = load ptr, ptr %5, align 8, !tbaa !14
  %78 = getelementptr inbounds nuw %struct.tree, ptr %77, i32 0, i32 0
  %79 = getelementptr inbounds [3 x double], ptr %78, i64 0, i64 2
  %80 = load double, ptr %79, align 8, !tbaa !21
  %81 = fsub double %76, %80
  %82 = load double, ptr %9, align 8, !tbaa !21
  %83 = fdiv double %81, %82
  store double %83, ptr %10, align 8, !tbaa !21
  %84 = load double, ptr %10, align 8, !tbaa !21
  %85 = fcmp ole double 0.000000e+00, %84
  br i1 %85, label %86, label %89

86:                                               ; preds = %69
  %87 = load double, ptr %10, align 8, !tbaa !21
  %88 = fcmp olt double %87, 1.000000e+00
  br i1 %88, label %91, label %89

89:                                               ; preds = %86, %69
  %90 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 7)
  call void @abort() #14
  unreachable

91:                                               ; preds = %86
  %92 = load double, ptr %10, align 8, !tbaa !21
  %93 = fmul double 0x41D0000000000000, %92
  %94 = call double @llvm.floor.f64(double %93)
  %95 = fptosi double %94 to i32
  %96 = getelementptr inbounds [3 x i32], ptr %11, i64 0, i64 2
  store i32 %95, ptr %96, align 4, !tbaa !5
  store i32 0, ptr %7, align 4, !tbaa !5
  store i32 0, ptr %8, align 4, !tbaa !5
  br label %97

97:                                               ; preds = %115, %91
  %98 = load i32, ptr %8, align 4, !tbaa !5
  %99 = icmp slt i32 %98, 3
  br i1 %99, label %100, label %118

100:                                              ; preds = %97
  %101 = load i32, ptr %8, align 4, !tbaa !5
  %102 = sext i32 %101 to i64
  %103 = getelementptr inbounds [3 x i32], ptr %11, i64 0, i64 %102
  %104 = load i32, ptr %103, align 4, !tbaa !5
  %105 = load i32, ptr %6, align 4, !tbaa !5
  %106 = and i32 %104, %105
  %107 = icmp ne i32 %106, 0
  br i1 %107, label %108, label %114

108:                                              ; preds = %100
  %109 = load i32, ptr %8, align 4, !tbaa !5
  %110 = add nsw i32 %109, 1
  %111 = ashr i32 8, %110
  %112 = load i32, ptr %7, align 4, !tbaa !5
  %113 = add nsw i32 %112, %111
  store i32 %113, ptr %7, align 4, !tbaa !5
  br label %114

114:                                              ; preds = %108, %100
  br label %115

115:                                              ; preds = %114
  %116 = load i32, ptr %8, align 4, !tbaa !5
  %117 = add nsw i32 %116, 1
  store i32 %117, ptr %8, align 4, !tbaa !5
  br label %97, !llvm.loop !109

118:                                              ; preds = %97
  %119 = load i32, ptr %7, align 4, !tbaa !5
  call void @llvm.lifetime.end.p0(i64 24, ptr %12) #11
  call void @llvm.lifetime.end.p0(i64 12, ptr %11) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %10) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %9) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %8) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %7) #11
  ret i32 %119
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.floor.f64(double) #7

; Function Attrs: nounwind uwtable
define dso_local i32 @ic_test(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca double, align 8
  %6 = alloca double, align 8
  %7 = alloca i32, align 4
  %8 = alloca [3 x double], align 16
  store ptr %0, ptr %3, align 8, !tbaa !15
  store ptr %1, ptr %4, align 8, !tbaa !14
  call void @llvm.lifetime.start.p0(i64 8, ptr %5) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %6) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %7) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %8) #11
  store i32 1, ptr %7, align 4, !tbaa !5
  %9 = load ptr, ptr %3, align 8, !tbaa !15
  %10 = getelementptr inbounds nuw %struct.bnode, ptr %9, i32 0, i32 2
  %11 = getelementptr inbounds [3 x double], ptr %10, i64 0, i64 0
  %12 = load double, ptr %11, align 8, !tbaa !21
  %13 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 0
  store double %12, ptr %13, align 16, !tbaa !21
  %14 = load ptr, ptr %3, align 8, !tbaa !15
  %15 = getelementptr inbounds nuw %struct.bnode, ptr %14, i32 0, i32 2
  %16 = getelementptr inbounds [3 x double], ptr %15, i64 0, i64 1
  %17 = load double, ptr %16, align 8, !tbaa !21
  %18 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 1
  store double %17, ptr %18, align 8, !tbaa !21
  %19 = load ptr, ptr %3, align 8, !tbaa !15
  %20 = getelementptr inbounds nuw %struct.bnode, ptr %19, i32 0, i32 2
  %21 = getelementptr inbounds [3 x double], ptr %20, i64 0, i64 2
  %22 = load double, ptr %21, align 8, !tbaa !21
  %23 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 2
  store double %22, ptr %23, align 16, !tbaa !21
  %24 = load ptr, ptr %4, align 8, !tbaa !14
  %25 = getelementptr inbounds nuw %struct.tree, ptr %24, i32 0, i32 1
  %26 = load double, ptr %25, align 8, !tbaa !22
  store double %26, ptr %6, align 8, !tbaa !21
  %27 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 0
  %28 = load double, ptr %27, align 16, !tbaa !21
  %29 = load ptr, ptr %4, align 8, !tbaa !14
  %30 = getelementptr inbounds nuw %struct.tree, ptr %29, i32 0, i32 0
  %31 = getelementptr inbounds [3 x double], ptr %30, i64 0, i64 0
  %32 = load double, ptr %31, align 8, !tbaa !21
  %33 = fsub double %28, %32
  %34 = load double, ptr %6, align 8, !tbaa !21
  %35 = fdiv double %33, %34
  store double %35, ptr %5, align 8, !tbaa !21
  %36 = load double, ptr %5, align 8, !tbaa !21
  %37 = fcmp ole double 0.000000e+00, %36
  br i1 %37, label %38, label %41

38:                                               ; preds = %2
  %39 = load double, ptr %5, align 8, !tbaa !21
  %40 = fcmp olt double %39, 1.000000e+00
  br i1 %40, label %42, label %41

41:                                               ; preds = %38, %2
  store i32 0, ptr %7, align 4, !tbaa !5
  br label %42

42:                                               ; preds = %41, %38
  %43 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 1
  %44 = load double, ptr %43, align 8, !tbaa !21
  %45 = load ptr, ptr %4, align 8, !tbaa !14
  %46 = getelementptr inbounds nuw %struct.tree, ptr %45, i32 0, i32 0
  %47 = getelementptr inbounds [3 x double], ptr %46, i64 0, i64 1
  %48 = load double, ptr %47, align 8, !tbaa !21
  %49 = fsub double %44, %48
  %50 = load double, ptr %6, align 8, !tbaa !21
  %51 = fdiv double %49, %50
  store double %51, ptr %5, align 8, !tbaa !21
  %52 = load double, ptr %5, align 8, !tbaa !21
  %53 = fcmp ole double 0.000000e+00, %52
  br i1 %53, label %54, label %57

54:                                               ; preds = %42
  %55 = load double, ptr %5, align 8, !tbaa !21
  %56 = fcmp olt double %55, 1.000000e+00
  br i1 %56, label %58, label %57

57:                                               ; preds = %54, %42
  store i32 0, ptr %7, align 4, !tbaa !5
  br label %58

58:                                               ; preds = %57, %54
  %59 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 2
  %60 = load double, ptr %59, align 16, !tbaa !21
  %61 = load ptr, ptr %4, align 8, !tbaa !14
  %62 = getelementptr inbounds nuw %struct.tree, ptr %61, i32 0, i32 0
  %63 = getelementptr inbounds [3 x double], ptr %62, i64 0, i64 2
  %64 = load double, ptr %63, align 8, !tbaa !21
  %65 = fsub double %60, %64
  %66 = load double, ptr %6, align 8, !tbaa !21
  %67 = fdiv double %65, %66
  store double %67, ptr %5, align 8, !tbaa !21
  %68 = load double, ptr %5, align 8, !tbaa !21
  %69 = fcmp ole double 0.000000e+00, %68
  br i1 %69, label %70, label %73

70:                                               ; preds = %58
  %71 = load double, ptr %5, align 8, !tbaa !21
  %72 = fcmp olt double %71, 1.000000e+00
  br i1 %72, label %74, label %73

73:                                               ; preds = %70, %58
  store i32 0, ptr %7, align 4, !tbaa !5
  br label %74

74:                                               ; preds = %73, %70
  %75 = load i32, ptr %7, align 4, !tbaa !5
  call void @llvm.lifetime.end.p0(i64 24, ptr %8) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %7) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %6) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %5) #11
  ret i32 %75
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #7

; Function Attrs: nounwind uwtable
define dso_local { i64, i64 } @intcoord1(double noundef %0, double noundef %1, double noundef %2, ptr noundef %3) #0 {
  %5 = alloca %struct.icstruct, align 4
  %6 = alloca double, align 8
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca ptr, align 8
  %10 = alloca double, align 8
  store double %0, ptr %6, align 8, !tbaa !21
  store double %1, ptr %7, align 8, !tbaa !21
  store double %2, ptr %8, align 8, !tbaa !21
  store ptr %3, ptr %9, align 8, !tbaa !14
  call void @llvm.lifetime.start.p0(i64 8, ptr %10) #11
  %11 = getelementptr inbounds nuw %struct.icstruct, ptr %5, i32 0, i32 1
  store i16 1, ptr %11, align 4, !tbaa !62
  %12 = load double, ptr %6, align 8, !tbaa !21
  %13 = load ptr, ptr %9, align 8, !tbaa !14
  %14 = getelementptr inbounds nuw %struct.tree, ptr %13, i32 0, i32 0
  %15 = getelementptr inbounds [3 x double], ptr %14, i64 0, i64 0
  %16 = load double, ptr %15, align 8, !tbaa !21
  %17 = fsub double %12, %16
  %18 = load ptr, ptr %9, align 8, !tbaa !14
  %19 = getelementptr inbounds nuw %struct.tree, ptr %18, i32 0, i32 1
  %20 = load double, ptr %19, align 8, !tbaa !22
  %21 = fdiv double %17, %20
  store double %21, ptr %10, align 8, !tbaa !21
  %22 = load double, ptr %10, align 8, !tbaa !21
  %23 = fcmp ole double 0.000000e+00, %22
  br i1 %23, label %24, label %34

24:                                               ; preds = %4
  %25 = load double, ptr %10, align 8, !tbaa !21
  %26 = fcmp olt double %25, 1.000000e+00
  br i1 %26, label %27, label %34

27:                                               ; preds = %24
  %28 = load double, ptr %10, align 8, !tbaa !21
  %29 = fmul double 0x41D0000000000000, %28
  %30 = call double @llvm.floor.f64(double %29)
  %31 = fptosi double %30 to i32
  %32 = getelementptr inbounds nuw %struct.icstruct, ptr %5, i32 0, i32 0
  %33 = getelementptr inbounds [3 x i32], ptr %32, i64 0, i64 0
  store i32 %31, ptr %33, align 4, !tbaa !5
  br label %36

34:                                               ; preds = %24, %4
  %35 = getelementptr inbounds nuw %struct.icstruct, ptr %5, i32 0, i32 1
  store i16 0, ptr %35, align 4, !tbaa !62
  br label %36

36:                                               ; preds = %34, %27
  %37 = load double, ptr %7, align 8, !tbaa !21
  %38 = load ptr, ptr %9, align 8, !tbaa !14
  %39 = getelementptr inbounds nuw %struct.tree, ptr %38, i32 0, i32 0
  %40 = getelementptr inbounds [3 x double], ptr %39, i64 0, i64 1
  %41 = load double, ptr %40, align 8, !tbaa !21
  %42 = fsub double %37, %41
  %43 = load ptr, ptr %9, align 8, !tbaa !14
  %44 = getelementptr inbounds nuw %struct.tree, ptr %43, i32 0, i32 1
  %45 = load double, ptr %44, align 8, !tbaa !22
  %46 = fdiv double %42, %45
  store double %46, ptr %10, align 8, !tbaa !21
  %47 = load double, ptr %10, align 8, !tbaa !21
  %48 = fcmp ole double 0.000000e+00, %47
  br i1 %48, label %49, label %59

49:                                               ; preds = %36
  %50 = load double, ptr %10, align 8, !tbaa !21
  %51 = fcmp olt double %50, 1.000000e+00
  br i1 %51, label %52, label %59

52:                                               ; preds = %49
  %53 = load double, ptr %10, align 8, !tbaa !21
  %54 = fmul double 0x41D0000000000000, %53
  %55 = call double @llvm.floor.f64(double %54)
  %56 = fptosi double %55 to i32
  %57 = getelementptr inbounds nuw %struct.icstruct, ptr %5, i32 0, i32 0
  %58 = getelementptr inbounds [3 x i32], ptr %57, i64 0, i64 1
  store i32 %56, ptr %58, align 4, !tbaa !5
  br label %61

59:                                               ; preds = %49, %36
  %60 = getelementptr inbounds nuw %struct.icstruct, ptr %5, i32 0, i32 1
  store i16 0, ptr %60, align 4, !tbaa !62
  br label %61

61:                                               ; preds = %59, %52
  %62 = load double, ptr %8, align 8, !tbaa !21
  %63 = load ptr, ptr %9, align 8, !tbaa !14
  %64 = getelementptr inbounds nuw %struct.tree, ptr %63, i32 0, i32 0
  %65 = getelementptr inbounds [3 x double], ptr %64, i64 0, i64 2
  %66 = load double, ptr %65, align 8, !tbaa !21
  %67 = fsub double %62, %66
  %68 = load ptr, ptr %9, align 8, !tbaa !14
  %69 = getelementptr inbounds nuw %struct.tree, ptr %68, i32 0, i32 1
  %70 = load double, ptr %69, align 8, !tbaa !22
  %71 = fdiv double %67, %70
  store double %71, ptr %10, align 8, !tbaa !21
  %72 = load double, ptr %10, align 8, !tbaa !21
  %73 = fcmp ole double 0.000000e+00, %72
  br i1 %73, label %74, label %84

74:                                               ; preds = %61
  %75 = load double, ptr %10, align 8, !tbaa !21
  %76 = fcmp olt double %75, 1.000000e+00
  br i1 %76, label %77, label %84

77:                                               ; preds = %74
  %78 = load double, ptr %10, align 8, !tbaa !21
  %79 = fmul double 0x41D0000000000000, %78
  %80 = call double @llvm.floor.f64(double %79)
  %81 = fptosi double %80 to i32
  %82 = getelementptr inbounds nuw %struct.icstruct, ptr %5, i32 0, i32 0
  %83 = getelementptr inbounds [3 x i32], ptr %82, i64 0, i64 2
  store i32 %81, ptr %83, align 4, !tbaa !5
  br label %86

84:                                               ; preds = %74, %61
  %85 = getelementptr inbounds nuw %struct.icstruct, ptr %5, i32 0, i32 1
  store i16 0, ptr %85, align 4, !tbaa !62
  br label %86

86:                                               ; preds = %84, %77
  call void @llvm.lifetime.end.p0(i64 8, ptr %10) #11
  %87 = load { i64, i64 }, ptr %5, align 4
  ret { i64, i64 } %87
}

; Function Attrs: nounwind uwtable
define dso_local void @freetree(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 8, !tbaa !65
  call void @llvm.lifetime.start.p0(i64 8, ptr %3) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #11
  %6 = load ptr, ptr %2, align 8, !tbaa !65
  %7 = icmp eq ptr %6, null
  br i1 %7, label %14, label %8

8:                                                ; preds = %1
  %9 = load ptr, ptr %2, align 8, !tbaa !65
  %10 = getelementptr inbounds nuw %struct.node, ptr %9, i32 0, i32 0
  %11 = load i16, ptr %10, align 8, !tbaa !96
  %12 = sext i16 %11 to i32
  %13 = icmp eq i32 %12, 1
  br i1 %13, label %14, label %15

14:                                               ; preds = %8, %1
  store i32 1, ptr %5, align 4
  br label %36

15:                                               ; preds = %8
  store i32 7, ptr %4, align 4, !tbaa !5
  br label %16

16:                                               ; preds = %31, %15
  %17 = load i32, ptr %4, align 4, !tbaa !5
  %18 = icmp sge i32 %17, 0
  br i1 %18, label %19, label %34

19:                                               ; preds = %16
  %20 = load ptr, ptr %2, align 8, !tbaa !65
  %rds.field.ptr = getelementptr inbounds %struct.cnode, ptr %20, i32 0, i32 6
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %21 = getelementptr inbounds nuw %struct.cnode, ptr %20, i32 0, i32 5
  %22 = load i32, ptr %4, align 4, !tbaa !5
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [8 x ptr], ptr %21, i64 0, i64 %23
  %25 = load ptr, ptr %24, align 8, !tbaa !65
  store ptr %25, ptr %3, align 8, !tbaa !65
  %26 = load ptr, ptr %3, align 8, !tbaa !65
  %27 = icmp ne ptr %26, null
  br i1 %27, label %28, label %30

28:                                               ; preds = %19
  %29 = load ptr, ptr %3, align 8, !tbaa !65
  call void @freetree(ptr noundef %29)
  br label %30

30:                                               ; preds = %28, %19
  br label %31

31:                                               ; preds = %30
  %32 = load i32, ptr %4, align 4, !tbaa !5
  %33 = add nsw i32 %32, -1
  store i32 %33, ptr %4, align 4, !tbaa !5
  br label %16, !llvm.loop !110

34:                                               ; preds = %16
  %35 = load ptr, ptr %2, align 8, !tbaa !65
  call void @my_free(ptr noundef %35)
  store i32 0, ptr %5, align 4
  br label %36

36:                                               ; preds = %34, %14
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %3) #11
  %37 = load i32, ptr %5, align 4
  switch i32 %37, label %39 [
    i32 0, label %38
    i32 1, label %38
  ]

38:                                               ; preds = %36, %36
  ret void

39:                                               ; preds = %36
  unreachable
}

; Function Attrs: nounwind uwtable
define dso_local void @my_free(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8, !tbaa !65
  %3 = load ptr, ptr %2, align 8, !tbaa !65
  %4 = getelementptr inbounds nuw %struct.node, ptr %3, i32 0, i32 0
  %5 = load i16, ptr %4, align 8, !tbaa !96
  %6 = sext i16 %5 to i32
  %7 = icmp eq i32 %6, 1
  br i1 %7, label %8, label %13

8:                                                ; preds = %1
  %9 = load ptr, ptr @bp_free_list, align 8, !tbaa !15
  %10 = load ptr, ptr %2, align 8, !tbaa !65
  %11 = getelementptr inbounds nuw %struct.bnode, ptr %10, i32 0, i32 9
  store ptr %9, ptr %11, align 8, !tbaa !30
  %12 = load ptr, ptr %2, align 8, !tbaa !65
  store ptr %12, ptr @bp_free_list, align 8, !tbaa !15
  br label %18

13:                                               ; preds = %1
  %14 = load ptr, ptr @cp_free_list, align 8, !tbaa !65
  %15 = load ptr, ptr %2, align 8, !tbaa !65
  %16 = getelementptr inbounds nuw %struct.cnode, ptr %15, i32 0, i32 6
  store ptr %14, ptr %16, align 8, !tbaa !104
  %17 = load ptr, ptr %2, align 8, !tbaa !65
  store ptr %17, ptr @cp_free_list, align 8, !tbaa !65
  br label %18

18:                                               ; preds = %13, %8
  ret void
}

; Function Attrs: nounwind
declare double @sqrt(double noundef) #3

; Function Attrs: nounwind uwtable
define dso_local ptr @ubody_alloc(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  store i32 %0, ptr %2, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 8, ptr %3) #11
  %4 = call noalias ptr @malloc(i64 noundef 144) #13
  store ptr %4, ptr %3, align 8, !tbaa !15
  %5 = load ptr, ptr %3, align 8, !tbaa !15
  %6 = getelementptr inbounds nuw %struct.bnode, ptr %5, i32 0, i32 0
  store i16 1, ptr %6, align 8, !tbaa !51
  %7 = load i32, ptr %2, align 4, !tbaa !5
  %8 = load ptr, ptr %3, align 8, !tbaa !15
  %9 = getelementptr inbounds nuw %struct.bnode, ptr %8, i32 0, i32 3
  store i32 %7, ptr %9, align 8, !tbaa !45
  %10 = load ptr, ptr %3, align 8, !tbaa !15
  %11 = getelementptr inbounds nuw %struct.bnode, ptr %10, i32 0, i32 10
  store ptr null, ptr %11, align 8, !tbaa !44
  %12 = load i32, ptr %2, align 4, !tbaa !5
  %13 = load ptr, ptr %3, align 8, !tbaa !15
  %14 = getelementptr inbounds nuw %struct.bnode, ptr %13, i32 0, i32 4
  store i32 %12, ptr %14, align 4, !tbaa !111
  %15 = load ptr, ptr %3, align 8, !tbaa !15
  call void @llvm.lifetime.end.p0(i64 8, ptr %3) #11
  ret ptr %15
}

; Function Attrs: nounwind
declare double @pow(double noundef, double noundef) #3

; Function Attrs: nounwind uwtable
define dso_local ptr @testdata() #0 {
  %1 = alloca double, align 8
  %2 = alloca double, align 8
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  %5 = alloca double, align 8
  %6 = alloca double, align 8
  %7 = alloca [3 x double], align 16
  %8 = alloca [3 x double], align 16
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  %13 = alloca double, align 8
  %14 = alloca double, align 8
  %15 = alloca double, align 8
  %16 = alloca i32, align 4
  %17 = alloca double, align 8
  %18 = alloca double, align 8
  %19 = alloca double, align 8
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr %1) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %2) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %3) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %4) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %5) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %6) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %7) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %8) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %9) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %10) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %11) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %12) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %13) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %14) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %15) #11
  store double 1.230000e+02, ptr %15, align 8, !tbaa !21
  call void @llvm.lifetime.start.p0(i64 4, ptr %16) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %17) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %18) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %19) #11
  %24 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef 99)
  call void @abort() #14
  unreachable
}

; Function Attrs: nounwind uwtable
define dso_local void @gravsub(ptr dead_on_unwind noalias writable sret(%struct.hgstruct) align 8 %0, ptr noundef %1, ptr noundef byval(%struct.hgstruct) align 8 %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca double, align 8
  %6 = alloca double, align 8
  %7 = alloca double, align 8
  %8 = alloca [3 x double], align 16
  %9 = alloca [3 x double], align 16
  %10 = alloca double, align 8
  %11 = alloca double, align 8
  %12 = alloca double, align 8
  %13 = alloca [3 x double], align 16
  %14 = alloca double, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  store ptr %1, ptr %4, align 8, !tbaa !65
  call void @llvm.lifetime.start.p0(i64 8, ptr %5) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %6) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %7) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %8) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %9) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %10) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %11) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %12) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %13) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %14) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %15) #11
  store i32 0, ptr %15, align 4, !tbaa !5
  br label %19

19:                                               ; preds = %38, %3
  %20 = load i32, ptr %15, align 4, !tbaa !5
  %21 = icmp slt i32 %20, 3
  br i1 %21, label %22, label %41

22:                                               ; preds = %19
  %23 = load ptr, ptr %4, align 8, !tbaa !65
  %24 = getelementptr inbounds nuw %struct.node, ptr %23, i32 0, i32 2
  %25 = load i32, ptr %15, align 4, !tbaa !5
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [3 x double], ptr %24, i64 0, i64 %26
  %28 = load double, ptr %27, align 8, !tbaa !21
  %29 = getelementptr inbounds nuw %struct.hgstruct, ptr %2, i32 0, i32 1
  %30 = load i32, ptr %15, align 4, !tbaa !5
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [3 x double], ptr %29, i64 0, i64 %31
  %33 = load double, ptr %32, align 8, !tbaa !21
  %34 = fsub double %28, %33
  %35 = load i32, ptr %15, align 4, !tbaa !5
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [3 x double], ptr %13, i64 0, i64 %36
  store double %34, ptr %37, align 8, !tbaa !21
  br label %38

38:                                               ; preds = %22
  %39 = load i32, ptr %15, align 4, !tbaa !5
  %40 = add nsw i32 %39, 1
  store i32 %40, ptr %15, align 4, !tbaa !5
  br label %19, !llvm.loop !112

41:                                               ; preds = %19
  call void @llvm.lifetime.end.p0(i64 4, ptr %15) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %16) #11
  store double 0.000000e+00, ptr %14, align 8, !tbaa !21
  store i32 0, ptr %16, align 4, !tbaa !5
  br label %42

42:                                               ; preds = %56, %41
  %43 = load i32, ptr %16, align 4, !tbaa !5
  %44 = icmp slt i32 %43, 3
  br i1 %44, label %45, label %59

45:                                               ; preds = %42
  %46 = load i32, ptr %16, align 4, !tbaa !5
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds [3 x double], ptr %13, i64 0, i64 %47
  %49 = load double, ptr %48, align 8, !tbaa !21
  %50 = load i32, ptr %16, align 4, !tbaa !5
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [3 x double], ptr %13, i64 0, i64 %51
  %53 = load double, ptr %52, align 8, !tbaa !21
  %54 = load double, ptr %14, align 8, !tbaa !21
  %55 = call double @llvm.fmuladd.f64(double %49, double %53, double %54)
  store double %55, ptr %14, align 8, !tbaa !21
  br label %56

56:                                               ; preds = %45
  %57 = load i32, ptr %16, align 4, !tbaa !5
  %58 = add nsw i32 %57, 1
  store i32 %58, ptr %16, align 4, !tbaa !5
  br label %42, !llvm.loop !113

59:                                               ; preds = %42
  call void @llvm.lifetime.end.p0(i64 4, ptr %16) #11
  %60 = load double, ptr %14, align 8, !tbaa !21
  %61 = fadd double %60, 0x3F647AE147AE147C
  store double %61, ptr %14, align 8, !tbaa !21
  %62 = load double, ptr %14, align 8, !tbaa !21
  %63 = call double @sqrt(double noundef %62) #11, !tbaa !5
  store double %63, ptr %5, align 8, !tbaa !21
  %64 = load ptr, ptr %4, align 8, !tbaa !65
  %65 = getelementptr inbounds nuw %struct.node, ptr %64, i32 0, i32 1
  %66 = load double, ptr %65, align 8, !tbaa !102
  %67 = load double, ptr %5, align 8, !tbaa !21
  %68 = fdiv double %66, %67
  store double %68, ptr %6, align 8, !tbaa !21
  %69 = load double, ptr %6, align 8, !tbaa !21
  %70 = getelementptr inbounds nuw %struct.hgstruct, ptr %2, i32 0, i32 2
  %71 = load double, ptr %70, align 8, !tbaa !86
  %72 = fsub double %71, %69
  store double %72, ptr %70, align 8, !tbaa !86
  %73 = load double, ptr %6, align 8, !tbaa !21
  %74 = load double, ptr %14, align 8, !tbaa !21
  %75 = fdiv double %73, %74
  store double %75, ptr %7, align 8, !tbaa !21
  call void @llvm.lifetime.start.p0(i64 4, ptr %17) #11
  store i32 0, ptr %17, align 4, !tbaa !5
  br label %76

76:                                               ; preds = %89, %59
  %77 = load i32, ptr %17, align 4, !tbaa !5
  %78 = icmp slt i32 %77, 3
  br i1 %78, label %79, label %92

79:                                               ; preds = %76
  %80 = load i32, ptr %17, align 4, !tbaa !5
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds [3 x double], ptr %13, i64 0, i64 %81
  %83 = load double, ptr %82, align 8, !tbaa !21
  %84 = load double, ptr %7, align 8, !tbaa !21
  %85 = fmul double %83, %84
  %86 = load i32, ptr %17, align 4, !tbaa !5
  %87 = sext i32 %86 to i64
  %88 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 %87
  store double %85, ptr %88, align 8, !tbaa !21
  br label %89

89:                                               ; preds = %79
  %90 = load i32, ptr %17, align 4, !tbaa !5
  %91 = add nsw i32 %90, 1
  store i32 %91, ptr %17, align 4, !tbaa !5
  br label %76, !llvm.loop !114

92:                                               ; preds = %76
  call void @llvm.lifetime.end.p0(i64 4, ptr %17) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %18) #11
  store i32 0, ptr %18, align 4, !tbaa !5
  br label %93

93:                                               ; preds = %111, %92
  %94 = load i32, ptr %18, align 4, !tbaa !5
  %95 = icmp slt i32 %94, 3
  br i1 %95, label %96, label %114

96:                                               ; preds = %93
  %97 = getelementptr inbounds nuw %struct.hgstruct, ptr %2, i32 0, i32 3
  %98 = load i32, ptr %18, align 4, !tbaa !5
  %99 = sext i32 %98 to i64
  %100 = getelementptr inbounds [3 x double], ptr %97, i64 0, i64 %99
  %101 = load double, ptr %100, align 8, !tbaa !21
  %102 = load i32, ptr %18, align 4, !tbaa !5
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds [3 x double], ptr %8, i64 0, i64 %103
  %105 = load double, ptr %104, align 8, !tbaa !21
  %106 = fadd double %101, %105
  %107 = getelementptr inbounds nuw %struct.hgstruct, ptr %2, i32 0, i32 3
  %108 = load i32, ptr %18, align 4, !tbaa !5
  %109 = sext i32 %108 to i64
  %110 = getelementptr inbounds [3 x double], ptr %107, i64 0, i64 %109
  store double %106, ptr %110, align 8, !tbaa !21
  br label %111

111:                                              ; preds = %96
  %112 = load i32, ptr %18, align 4, !tbaa !5
  %113 = add nsw i32 %112, 1
  store i32 %113, ptr %18, align 4, !tbaa !5
  br label %93, !llvm.loop !115

114:                                              ; preds = %93
  call void @llvm.lifetime.end.p0(i64 4, ptr %18) #11
  %115 = load ptr, ptr %4, align 8, !tbaa !65
  %116 = getelementptr inbounds nuw %struct.node, ptr %115, i32 0, i32 0
  %117 = load i16, ptr %116, align 8, !tbaa !96
  %118 = sext i16 %117 to i32
  %119 = icmp eq i32 %118, 2
  br i1 %119, label %120, label %121

120:                                              ; preds = %114
  br label %121

121:                                              ; preds = %120, %114
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %0, ptr align 8 %2, i64 64, i1 false), !tbaa.struct !88
  call void @llvm.lifetime.end.p0(i64 8, ptr %14) #11
  call void @llvm.lifetime.end.p0(i64 24, ptr %13) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %12) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %11) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %10) #11
  call void @llvm.lifetime.end.p0(i64 24, ptr %9) #11
  call void @llvm.lifetime.end.p0(i64 24, ptr %8) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %7) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %6) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %5) #11
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local signext i16 @subdivp(ptr noundef %0, double noundef %1, double noundef %2, ptr noundef byval(%struct.hgstruct) align 8 %3) #0 {
  %5 = alloca i16, align 2
  %6 = alloca ptr, align 8
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca ptr, align 8
  %10 = alloca [3 x double], align 16
  %11 = alloca [3 x double], align 16
  %12 = alloca double, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  store ptr %0, ptr %6, align 8, !tbaa !65
  store double %1, ptr %7, align 8, !tbaa !21
  store double %2, ptr %8, align 8, !tbaa !21
  call void @llvm.lifetime.start.p0(i64 8, ptr %9) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %10) #11
  call void @llvm.lifetime.start.p0(i64 24, ptr %11) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %12) #11
  %16 = load ptr, ptr %6, align 8, !tbaa !65
  store ptr %16, ptr %9, align 8, !tbaa !65
  %17 = load ptr, ptr %9, align 8, !tbaa !65
  %18 = getelementptr inbounds nuw %struct.node, ptr %17, i32 0, i32 0
  %19 = load i16, ptr %18, align 8, !tbaa !96
  %20 = sext i16 %19 to i32
  %21 = icmp eq i32 %20, 1
  br i1 %21, label %22, label %23

22:                                               ; preds = %4
  store i16 0, ptr %5, align 2
  store i32 1, ptr %13, align 4
  br label %72

23:                                               ; preds = %4
  call void @llvm.lifetime.start.p0(i64 4, ptr %14) #11
  store i32 0, ptr %14, align 4, !tbaa !5
  br label %24

24:                                               ; preds = %43, %23
  %25 = load i32, ptr %14, align 4, !tbaa !5
  %26 = icmp slt i32 %25, 3
  br i1 %26, label %27, label %46

27:                                               ; preds = %24
  %28 = load ptr, ptr %9, align 8, !tbaa !65
  %29 = getelementptr inbounds nuw %struct.node, ptr %28, i32 0, i32 2
  %30 = load i32, ptr %14, align 4, !tbaa !5
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [3 x double], ptr %29, i64 0, i64 %31
  %33 = load double, ptr %32, align 8, !tbaa !21
  %34 = getelementptr inbounds nuw %struct.hgstruct, ptr %3, i32 0, i32 1
  %35 = load i32, ptr %14, align 4, !tbaa !5
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [3 x double], ptr %34, i64 0, i64 %36
  %38 = load double, ptr %37, align 8, !tbaa !21
  %39 = fsub double %33, %38
  %40 = load i32, ptr %14, align 4, !tbaa !5
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [3 x double], ptr %10, i64 0, i64 %41
  store double %39, ptr %42, align 8, !tbaa !21
  br label %43

43:                                               ; preds = %27
  %44 = load i32, ptr %14, align 4, !tbaa !5
  %45 = add nsw i32 %44, 1
  store i32 %45, ptr %14, align 4, !tbaa !5
  br label %24, !llvm.loop !116

46:                                               ; preds = %24
  call void @llvm.lifetime.end.p0(i64 4, ptr %14) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %15) #11
  store double 0.000000e+00, ptr %12, align 8, !tbaa !21
  store i32 0, ptr %15, align 4, !tbaa !5
  br label %47

47:                                               ; preds = %61, %46
  %48 = load i32, ptr %15, align 4, !tbaa !5
  %49 = icmp slt i32 %48, 3
  br i1 %49, label %50, label %64

50:                                               ; preds = %47
  %51 = load i32, ptr %15, align 4, !tbaa !5
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds [3 x double], ptr %10, i64 0, i64 %52
  %54 = load double, ptr %53, align 8, !tbaa !21
  %55 = load i32, ptr %15, align 4, !tbaa !5
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds [3 x double], ptr %10, i64 0, i64 %56
  %58 = load double, ptr %57, align 8, !tbaa !21
  %59 = load double, ptr %12, align 8, !tbaa !21
  %60 = call double @llvm.fmuladd.f64(double %54, double %58, double %59)
  store double %60, ptr %12, align 8, !tbaa !21
  br label %61

61:                                               ; preds = %50
  %62 = load i32, ptr %15, align 4, !tbaa !5
  %63 = add nsw i32 %62, 1
  store i32 %63, ptr %15, align 4, !tbaa !5
  br label %47, !llvm.loop !117

64:                                               ; preds = %47
  call void @llvm.lifetime.end.p0(i64 4, ptr %15) #11
  %65 = load double, ptr %8, align 8, !tbaa !21
  %66 = load double, ptr %12, align 8, !tbaa !21
  %67 = fmul double %65, %66
  %68 = load double, ptr %7, align 8, !tbaa !21
  %69 = fcmp olt double %67, %68
  %70 = zext i1 %69 to i32
  %71 = trunc i32 %70 to i16
  store i16 %71, ptr %5, align 2
  store i32 1, ptr %13, align 4
  br label %72

72:                                               ; preds = %64, %22
  call void @llvm.lifetime.end.p0(i64 8, ptr %12) #11
  call void @llvm.lifetime.end.p0(i64 24, ptr %11) #11
  call void @llvm.lifetime.end.p0(i64 24, ptr %10) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %9) #11
  %73 = load i16, ptr %5, align 2
  ret i16 %73
}

; Function Attrs: nounwind uwtable
define dso_local void @printtree(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8, !tbaa !65
  %3 = load ptr, ptr %2, align 8, !tbaa !65
  call void @ptree(ptr noundef %3, i32 noundef 0)
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @ptree(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 8, !tbaa !65
  store i32 %1, ptr %4, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 8, ptr %5) #11
  %7 = load ptr, ptr %3, align 8, !tbaa !65
  %8 = icmp ne ptr %7, null
  br i1 %8, label %9, label %65

9:                                                ; preds = %2
  %10 = load ptr, ptr %3, align 8, !tbaa !65
  %11 = getelementptr inbounds nuw %struct.node, ptr %10, i32 0, i32 0
  %12 = load i16, ptr %11, align 8, !tbaa !96
  %13 = sext i16 %12 to i32
  %14 = icmp eq i32 %13, 1
  br i1 %14, label %15, label %31

15:                                               ; preds = %9
  %16 = load i32, ptr %4, align 4, !tbaa !5
  %17 = load ptr, ptr %3, align 8, !tbaa !65
  %18 = load ptr, ptr %3, align 8, !tbaa !65
  %19 = getelementptr inbounds nuw %struct.node, ptr %18, i32 0, i32 2
  %20 = getelementptr inbounds [3 x double], ptr %19, i64 0, i64 0
  %21 = load double, ptr %20, align 8, !tbaa !21
  %22 = load ptr, ptr %3, align 8, !tbaa !65
  %23 = getelementptr inbounds nuw %struct.node, ptr %22, i32 0, i32 2
  %24 = getelementptr inbounds [3 x double], ptr %23, i64 0, i64 1
  %25 = load double, ptr %24, align 8, !tbaa !21
  %26 = load ptr, ptr %3, align 8, !tbaa !65
  %27 = getelementptr inbounds nuw %struct.node, ptr %26, i32 0, i32 2
  %28 = getelementptr inbounds [3 x double], ptr %27, i64 0, i64 2
  %29 = load double, ptr %28, align 8, !tbaa !21
  %30 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %16, ptr noundef %17, double noundef %21, double noundef %25, double noundef %29)
  br label %64

31:                                               ; preds = %9
  call void @llvm.lifetime.start.p0(i64 4, ptr %6) #11
  %32 = load i32, ptr %4, align 4, !tbaa !5
  %33 = load ptr, ptr %3, align 8, !tbaa !65
  %34 = load ptr, ptr %3, align 8, !tbaa !65
  %35 = getelementptr inbounds nuw %struct.node, ptr %34, i32 0, i32 2
  %36 = getelementptr inbounds [3 x double], ptr %35, i64 0, i64 0
  %37 = load double, ptr %36, align 8, !tbaa !21
  %38 = load ptr, ptr %3, align 8, !tbaa !65
  %39 = getelementptr inbounds nuw %struct.node, ptr %38, i32 0, i32 2
  %40 = getelementptr inbounds [3 x double], ptr %39, i64 0, i64 1
  %41 = load double, ptr %40, align 8, !tbaa !21
  %42 = load ptr, ptr %3, align 8, !tbaa !65
  %43 = getelementptr inbounds nuw %struct.node, ptr %42, i32 0, i32 2
  %44 = getelementptr inbounds [3 x double], ptr %43, i64 0, i64 2
  %45 = load double, ptr %44, align 8, !tbaa !21
  %46 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %32, ptr noundef %33, double noundef %37, double noundef %41, double noundef %45)
  store i32 0, ptr %6, align 4, !tbaa !5
  br label %47

47:                                               ; preds = %60, %31
  %48 = load i32, ptr %6, align 4, !tbaa !5
  %49 = icmp slt i32 %48, 8
  br i1 %49, label %50, label %63

50:                                               ; preds = %47
  %51 = load ptr, ptr %3, align 8, !tbaa !65
  %rds.field.ptr = getelementptr inbounds %struct.cnode, ptr %51, i32 0, i32 6
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %52 = getelementptr inbounds nuw %struct.cnode, ptr %51, i32 0, i32 5
  %53 = load i32, ptr %6, align 4, !tbaa !5
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [8 x ptr], ptr %52, i64 0, i64 %54
  %56 = load ptr, ptr %55, align 8, !tbaa !65
  store ptr %56, ptr %5, align 8, !tbaa !65
  %57 = load ptr, ptr %5, align 8, !tbaa !65
  %58 = load i32, ptr %4, align 4, !tbaa !5
  %59 = add nsw i32 %58, 1
  call void @ptree(ptr noundef %57, i32 noundef %59)
  br label %60

60:                                               ; preds = %50
  %61 = load i32, ptr %6, align 4, !tbaa !5
  %62 = add nsw i32 %61, 1
  store i32 %62, ptr %6, align 4, !tbaa !5
  br label %47, !llvm.loop !118

63:                                               ; preds = %47
  call void @llvm.lifetime.end.p0(i64 4, ptr %6) #11
  br label %64

64:                                               ; preds = %63, %15
  br label %68

65:                                               ; preds = %2
  %66 = load i32, ptr %4, align 4, !tbaa !5
  %67 = call i32 (ptr, ...) @printf(ptr noundef @.str.7, i32 noundef %66)
  br label %68

68:                                               ; preds = %65, %64
  call void @llvm.lifetime.end.p0(i64 8, ptr %5) #11
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @dis_number(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8, !tbaa !65
  call void @llvm.lifetime.start.p0(i64 4, ptr %3) #11
  %4 = load i32, ptr @nbody, align 4, !tbaa !5
  %5 = sitofp i32 %4 to double
  %6 = load i32, ptr @NumNodes, align 4, !tbaa !5
  %7 = sitofp i32 %6 to double
  %8 = fdiv double %5, %7
  %9 = call double @llvm.ceil.f64(double %8)
  %10 = fptosi double %9 to i32
  store i32 %10, ptr %3, align 4, !tbaa !5
  %11 = load ptr, ptr %2, align 8, !tbaa !65
  %12 = load i32, ptr %3, align 4, !tbaa !5
  %13 = call i32 @dis2_number(ptr noundef %11, i32 noundef -1, i32 noundef %12)
  call void @llvm.lifetime.end.p0(i64 4, ptr %3) #11
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.ceil.f64(double) #7

; Function Attrs: nounwind uwtable
define dso_local i32 @dis2_number(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  store ptr %0, ptr %5, align 8, !tbaa !65
  store i32 %1, ptr %6, align 4, !tbaa !5
  store i32 %2, ptr %7, align 4, !tbaa !5
  %10 = load ptr, ptr %5, align 8, !tbaa !65
  %11 = icmp eq ptr %10, null
  br i1 %11, label %12, label %14

12:                                               ; preds = %3
  %13 = load i32, ptr %6, align 4, !tbaa !5
  store i32 %13, ptr %4, align 4
  br label %49

14:                                               ; preds = %3
  %15 = load ptr, ptr %5, align 8, !tbaa !65
  %16 = getelementptr inbounds nuw %struct.node, ptr %15, i32 0, i32 0
  %17 = load i16, ptr %16, align 8, !tbaa !96
  %18 = sext i16 %17 to i32
  %19 = icmp eq i32 %18, 1
  br i1 %19, label %20, label %29

20:                                               ; preds = %14
  %21 = load i32, ptr %6, align 4, !tbaa !5
  %22 = add nsw i32 %21, 1
  %23 = load i32, ptr %7, align 4, !tbaa !5
  %24 = sdiv i32 %22, %23
  %25 = load ptr, ptr %5, align 8, !tbaa !65
  %26 = getelementptr inbounds nuw %struct.node, ptr %25, i32 0, i32 4
  store i32 %24, ptr %26, align 4, !tbaa !119
  %27 = load i32, ptr %6, align 4, !tbaa !5
  %28 = add nsw i32 %27, 1
  store i32 %28, ptr %4, align 4
  br label %49

29:                                               ; preds = %14
  call void @llvm.lifetime.start.p0(i64 4, ptr %8) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %9) #11
  store i32 0, ptr %8, align 4, !tbaa !5
  br label %30

30:                                               ; preds = %44, %29
  %31 = load i32, ptr %8, align 4, !tbaa !5
  %32 = icmp slt i32 %31, 8
  br i1 %32, label %33, label %47

33:                                               ; preds = %30
  %34 = load ptr, ptr %5, align 8, !tbaa !65
  %rds.field.ptr = getelementptr inbounds %struct.cnode, ptr %34, i32 0, i32 6
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %35 = getelementptr inbounds nuw %struct.cnode, ptr %34, i32 0, i32 5
  %36 = load i32, ptr %8, align 4, !tbaa !5
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [8 x ptr], ptr %35, i64 0, i64 %37
  %39 = load ptr, ptr %38, align 8, !tbaa !65
  store ptr %39, ptr %9, align 8, !tbaa !65
  %40 = load ptr, ptr %9, align 8, !tbaa !65
  %41 = load i32, ptr %6, align 4, !tbaa !5
  %42 = load i32, ptr %7, align 4, !tbaa !5
  %43 = call i32 @dis2_number(ptr noundef %40, i32 noundef %41, i32 noundef %42)
  store i32 %43, ptr %6, align 4, !tbaa !5
  br label %44

44:                                               ; preds = %33
  %45 = load i32, ptr %8, align 4, !tbaa !5
  %46 = add nsw i32 %45, 1
  store i32 %46, ptr %8, align 4, !tbaa !5
  br label %30, !llvm.loop !120

47:                                               ; preds = %30
  %48 = load i32, ptr %6, align 4, !tbaa !5
  store i32 %48, ptr %4, align 4
  call void @llvm.lifetime.end.p0(i64 8, ptr %9) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %8) #11
  br label %49

49:                                               ; preds = %47, %20, %12
  %50 = load i32, ptr %4, align 4
  ret i32 %50
}

; Function Attrs: nounwind uwtable
define dso_local double @my_rand(double noundef %0) #0 {
  %2 = alloca double, align 8
  %3 = alloca double, align 8
  store double %0, ptr %2, align 8, !tbaa !21
  call void @llvm.lifetime.start.p0(i64 8, ptr %3) #11
  %4 = load double, ptr %2, align 8, !tbaa !21
  %5 = call double @llvm.fmuladd.f64(double 1.680700e+04, double %4, double 1.000000e+00)
  store double %5, ptr %3, align 8, !tbaa !21
  %6 = load double, ptr %3, align 8, !tbaa !21
  %7 = load double, ptr %3, align 8, !tbaa !21
  %8 = fdiv double %7, 0x41DFFFFFFFC00000
  %9 = call double @llvm.floor.f64(double %8)
  %10 = call double @llvm.fmuladd.f64(double 0xC1DFFFFFFFC00000, double %9, double %6)
  store double %10, ptr %2, align 8, !tbaa !21
  %11 = load double, ptr %2, align 8, !tbaa !21
  call void @llvm.lifetime.end.p0(i64 8, ptr %3) #11
  ret double %11
}

; Function Attrs: nounwind uwtable
define dso_local double @xrand(double noundef %0, double noundef %1, double noundef %2) #0 {
  %4 = alloca double, align 8
  %5 = alloca double, align 8
  %6 = alloca double, align 8
  %7 = alloca double, align 8
  store double %0, ptr %4, align 8, !tbaa !21
  store double %1, ptr %5, align 8, !tbaa !21
  store double %2, ptr %6, align 8, !tbaa !21
  call void @llvm.lifetime.start.p0(i64 8, ptr %7) #11
  %8 = load double, ptr %4, align 8, !tbaa !21
  %9 = load double, ptr %5, align 8, !tbaa !21
  %10 = load double, ptr %4, align 8, !tbaa !21
  %11 = fsub double %9, %10
  %12 = load double, ptr %6, align 8, !tbaa !21
  %13 = fmul double %11, %12
  %14 = fdiv double %13, 0x41DFFFFFFFC00000
  %15 = fadd double %8, %14
  store double %15, ptr %7, align 8, !tbaa !21
  %16 = load double, ptr %7, align 8, !tbaa !21
  call void @llvm.lifetime.end.p0(i64 8, ptr %7) #11
  ret double %16
}

; Function Attrs: nounwind uwtable
define dso_local void @error(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8, !tbaa !12
  %3 = load ptr, ptr @stderr, align 8, !tbaa !121
  %4 = load ptr, ptr %2, align 8, !tbaa !12
  %5 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %3, ptr noundef @.str.11, ptr noundef %4) #11
  %6 = call ptr @__errno_location() #15
  %7 = load i32, ptr %6, align 4, !tbaa !5
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %10

9:                                                ; preds = %1
  call void @perror(ptr noundef @.str.1.12)
  br label %10

10:                                               ; preds = %9, %1
  call void @exit(i32 noundef 0) #14
  unreachable
}

; Function Attrs: nounwind
declare i32 @fprintf(ptr noundef, ptr noundef, ...) #3

; Function Attrs: nounwind willreturn memory(none)
declare ptr @__errno_location() #9

declare void @perror(ptr noundef) #4

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #8

; Function Attrs: nounwind uwtable
define dso_local void @walksub(ptr dead_on_unwind noalias writable sret(%struct.hgstruct) align 8 %0, ptr noundef %1, double noundef %2, double noundef %3, ptr noundef byval(%struct.hgstruct) align 8 %4, i32 noundef %5) #0 {
  %7 = alloca ptr, align 8
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca ptr, align 8
  %14 = alloca [8 x ptr], align 16
  %15 = alloca %struct.hgstruct, align 8
  %16 = alloca %struct.hgstruct, align 8
  store ptr %1, ptr %7, align 8, !tbaa !65
  store double %2, ptr %8, align 8, !tbaa !21
  store double %3, ptr %9, align 8, !tbaa !21
  store i32 %5, ptr %10, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 4, ptr %11) #11
  call void @llvm.lifetime.start.p0(i64 4, ptr %12) #11
  call void @llvm.lifetime.start.p0(i64 8, ptr %13) #11
  call void @llvm.lifetime.start.p0(i64 64, ptr %14) #11
  %17 = load ptr, ptr %7, align 8, !tbaa !65
  %18 = load double, ptr %8, align 8, !tbaa !21
  %19 = load double, ptr %9, align 8, !tbaa !21
  %20 = call signext i16 @subdivp(ptr noundef %17, double noundef %18, double noundef %19, ptr noundef byval(%struct.hgstruct) align 8 %4)
  %21 = icmp ne i16 %20, 0
  br i1 %21, label %22, label %47

22:                                               ; preds = %6
  store i32 0, ptr %11, align 4, !tbaa !5
  br label %23

23:                                               ; preds = %43, %22
  %24 = load i32, ptr %11, align 4, !tbaa !5
  %25 = icmp slt i32 %24, 8
  br i1 %25, label %26, label %46

26:                                               ; preds = %23
  %27 = load ptr, ptr %7, align 8, !tbaa !65
  %rds.field.ptr = getelementptr inbounds %struct.cnode, ptr %27, i32 0, i32 6
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %28 = getelementptr inbounds nuw %struct.cnode, ptr %27, i32 0, i32 5
  %29 = load i32, ptr %11, align 4, !tbaa !5
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [8 x ptr], ptr %28, i64 0, i64 %30
  %32 = load ptr, ptr %31, align 8, !tbaa !65
  store ptr %32, ptr %13, align 8, !tbaa !65
  %33 = load ptr, ptr %13, align 8, !tbaa !65
  %34 = icmp ne ptr %33, null
  br i1 %34, label %35, label %42

35:                                               ; preds = %26
  call void @llvm.lifetime.start.p0(i64 64, ptr %15) #11
  %36 = load ptr, ptr %13, align 8, !tbaa !65
  %37 = load double, ptr %8, align 8, !tbaa !21
  %38 = fdiv double %37, 4.000000e+00
  %39 = load double, ptr %9, align 8, !tbaa !21
  %40 = load i32, ptr %10, align 4, !tbaa !5
  %41 = add nsw i32 %40, 1
  %rds.field.ptr1 = getelementptr inbounds %struct.hgstruct, ptr %15, i32 0, i32 0
  %rds.field.val2 = load ptr, ptr %rds.field.ptr1, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val2, i32 0, i32 3, i32 1)
  %rds.field.ptr3 = getelementptr inbounds %struct.hgstruct, ptr %4, i32 0, i32 0
  %rds.field.val4 = load ptr, ptr %rds.field.ptr3, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val4, i32 0, i32 3, i32 1)
  call void @walksub(ptr dead_on_unwind writable sret(%struct.hgstruct) align 8 %15, ptr noundef %36, double noundef %38, double noundef %39, ptr noundef byval(%struct.hgstruct) align 8 %4, i32 noundef %41)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %4, ptr align 8 %15, i64 64, i1 false), !tbaa.struct !88
  call void @llvm.lifetime.end.p0(i64 64, ptr %15) #11
  br label %42

42:                                               ; preds = %35, %26
  br label %43

43:                                               ; preds = %42
  %44 = load i32, ptr %11, align 4, !tbaa !5
  %45 = add nsw i32 %44, 1
  store i32 %45, ptr %11, align 4, !tbaa !5
  br label %23, !llvm.loop !123

46:                                               ; preds = %23
  br label %55

47:                                               ; preds = %6
  %48 = load ptr, ptr %7, align 8, !tbaa !65
  %49 = getelementptr inbounds nuw %struct.hgstruct, ptr %4, i32 0, i32 0
  %50 = load ptr, ptr %49, align 8, !tbaa !83
  %51 = icmp ne ptr %48, %50
  br i1 %51, label %52, label %54

52:                                               ; preds = %47
  call void @llvm.lifetime.start.p0(i64 64, ptr %16) #11
  %53 = load ptr, ptr %7, align 8, !tbaa !65
  call void @gravsub(ptr dead_on_unwind writable sret(%struct.hgstruct) align 8 %16, ptr noundef %53, ptr noundef byval(%struct.hgstruct) align 8 %4)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %4, ptr align 8 %16, i64 64, i1 false), !tbaa.struct !88
  call void @llvm.lifetime.end.p0(i64 64, ptr %16) #11
  br label %54

54:                                               ; preds = %52, %47
  br label %55

55:                                               ; preds = %54, %46
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %0, ptr align 8 %4, i64 64, i1 false), !tbaa.struct !88
  call void @llvm.lifetime.end.p0(i64 64, ptr %14) #11
  call void @llvm.lifetime.end.p0(i64 8, ptr %13) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %12) #11
  call void @llvm.lifetime.end.p0(i64 4, ptr %11) #11
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @llvm.prefetch.p0(ptr nocapture readonly, i32 immarg, i32 immarg, i32 immarg) #10

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { inlinehint nounwind willreturn memory(read) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { nounwind willreturn memory(none) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #10 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite) }
attributes #11 = { nounwind }
attributes #12 = { nounwind willreturn memory(read) }
attributes #13 = { nounwind allocsize(0) }
attributes #14 = { noreturn nounwind }
attributes #15 = { nounwind willreturn memory(none) }

!llvm.ident = !{!0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3, !4}

!0 = !{!"clang version 20.1.8 (https://github.com/llvm/llvm-project.git 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"p2 omnipotent char", !11, i64 0}
!11 = !{!"any pointer", !7, i64 0}
!12 = !{!13, !13, i64 0}
!13 = !{!"p1 omnipotent char", !11, i64 0}
!14 = !{!11, !11, i64 0}
!15 = !{!16, !16, i64 0}
!16 = !{!"p1 _ZTS5bnode", !11, i64 0}
!17 = !{!18, !20, i64 32}
!18 = !{!"", !7, i64 0, !19, i64 24, !20, i64 32, !7, i64 40, !7, i64 552}
!19 = !{!"double", !7, i64 0}
!20 = !{!"p1 _ZTS4node", !11, i64 0}
!21 = !{!19, !19, i64 0}
!22 = !{!18, !19, i64 24}
!23 = distinct !{!23, !24}
!24 = !{!"llvm.loop.unroll.disable"}
!25 = distinct !{!25, !24}
!26 = !{i64 0, i64 24, !27, i64 24, i64 24, !27, i64 48, i64 8, !15, i64 56, i64 8, !15}
!27 = !{!7, !7, i64 0}
!28 = !{!29, !16, i64 48}
!29 = !{!"", !7, i64 0, !7, i64 24, !16, i64 48, !16, i64 56}
!30 = !{!31, !16, i64 128}
!31 = !{!"bnode", !32, i64 0, !19, i64 8, !7, i64 16, !6, i64 40, !6, i64 44, !7, i64 48, !7, i64 72, !7, i64 96, !19, i64 120, !16, i64 128, !16, i64 136}
!32 = !{!"short", !7, i64 0}
!33 = !{!29, !16, i64 56}
!34 = distinct !{!34, !24}
!35 = distinct !{!35, !24}
!36 = distinct !{!36, !24}
!37 = distinct !{!37, !24}
!38 = distinct !{!38, !24}
!39 = distinct !{!39, !24}
!40 = distinct !{!40, !24}
!41 = distinct !{!41, !24}
!42 = !{i64 0, i64 12, !27, i64 12, i64 2, !43}
!43 = !{!32, !32, i64 0}
!44 = !{!31, !16, i64 136}
!45 = !{!31, !6, i64 40}
!46 = distinct !{!46, !24}
!47 = distinct !{!47, !24}
!48 = distinct !{!48, !24}
!49 = distinct !{!49, !24}
!50 = distinct !{!50, !24}
!51 = !{!31, !32, i64 0}
!52 = !{!31, !19, i64 8}
!53 = distinct !{!53, !24}
!54 = distinct !{!54, !24}
!55 = distinct !{!55, !24}
!56 = distinct !{!56, !24}
!57 = distinct !{!57, !24}
!58 = distinct !{!58, !24}
!59 = distinct !{!59, !24}
!60 = distinct !{!60, !24}
!61 = distinct !{!61, !24}
!62 = !{!63, !32, i64 12}
!63 = !{!"", !7, i64 0, !32, i64 12}
!64 = distinct !{!64, !24}
!65 = !{!20, !20, i64 0}
!66 = distinct !{!66, !24}
!67 = distinct !{!67, !24}
!68 = distinct !{!68, !24}
!69 = distinct !{!69, !24}
!70 = distinct !{!70, !24}
!71 = distinct !{!71, !24}
!72 = distinct !{!72, !24}
!73 = distinct !{!73, !24}
!74 = distinct !{!74, !24}
!75 = distinct !{!75, !24}
!76 = distinct !{!76, !24}
!77 = distinct !{!77, !24}
!78 = distinct !{!78, !24}
!79 = distinct !{!79, !24}
!80 = distinct !{!80, !24}
!81 = distinct !{!81, !24}
!82 = distinct !{!82, !24}
!83 = !{!84, !16, i64 0}
!84 = !{!"", !16, i64 0, !7, i64 8, !19, i64 32, !7, i64 40}
!85 = distinct !{!85, !24}
!86 = !{!84, !19, i64 32}
!87 = distinct !{!87, !24}
!88 = !{i64 0, i64 8, !15, i64 8, i64 24, !27, i64 32, i64 8, !21, i64 40, i64 24, !27}
!89 = !{!31, !19, i64 120}
!90 = distinct !{!90, !24}
!91 = distinct !{!91, !24}
!92 = distinct !{!92, !24}
!93 = !{!94, !94, i64 0}
!94 = !{!"p1 _ZTS5cnode", !11, i64 0}
!95 = distinct !{!95, !24}
!96 = !{!97, !32, i64 0}
!97 = !{!"node", !32, i64 0, !19, i64 8, !7, i64 16, !6, i64 40, !6, i64 44}
!98 = distinct !{!98, !24}
!99 = distinct !{!99, !24}
!100 = distinct !{!100, !24}
!101 = distinct !{!101, !24}
!102 = !{!97, !19, i64 8}
!103 = distinct !{!103, !24}
!104 = !{!105, !94, i64 112}
!105 = !{!"cnode", !32, i64 0, !19, i64 8, !7, i64 16, !6, i64 40, !6, i64 44, !7, i64 48, !94, i64 112}
!106 = !{!105, !32, i64 0}
!107 = !{!105, !6, i64 40}
!108 = distinct !{!108, !24}
!109 = distinct !{!109, !24}
!110 = distinct !{!110, !24}
!111 = !{!31, !6, i64 44}
!112 = distinct !{!112, !24}
!113 = distinct !{!113, !24}
!114 = distinct !{!114, !24}
!115 = distinct !{!115, !24}
!116 = distinct !{!116, !24}
!117 = distinct !{!117, !24}
!118 = distinct !{!118, !24}
!119 = !{!97, !6, i64 44}
!120 = distinct !{!120, !24}
!121 = !{!122, !122, i64 0}
!122 = !{!"p1 _ZTS8_IO_FILE", !11, i64 0}
!123 = distinct !{!123, !24}
