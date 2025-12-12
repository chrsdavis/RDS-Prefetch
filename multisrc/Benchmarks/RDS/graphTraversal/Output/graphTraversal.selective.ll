; ModuleID = 'Output/graphTraversal.selective.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.GraphNode = type { i32, i32, [4 x ptr] }

@.str = private unnamed_addr constant [30 x i8] c"Creating graph with %d nodes\0A\00", align 1
@.str.1 = private unnamed_addr constant [27 x i8] c"Traversing graph %d times\0A\00", align 1
@.str.2 = private unnamed_addr constant [18 x i8] c"Total sum : %lld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local ptr @createNode(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store i32 %0, ptr %2, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 8, ptr %3) #7
  %5 = call noalias ptr @malloc(i64 noundef 40) #8
  store ptr %5, ptr %3, align 8, !tbaa !9
  %6 = load i32, ptr %2, align 4, !tbaa !5
  %7 = load ptr, ptr %3, align 8, !tbaa !9
  %8 = getelementptr inbounds nuw %struct.GraphNode, ptr %7, i32 0, i32 0
  store i32 %6, ptr %8, align 8, !tbaa !12
  %9 = load ptr, ptr %3, align 8, !tbaa !9
  %10 = getelementptr inbounds nuw %struct.GraphNode, ptr %9, i32 0, i32 1
  store i32 0, ptr %10, align 4, !tbaa !14
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #7
  store i32 0, ptr %4, align 4, !tbaa !5
  br label %11

11:                                               ; preds = %21, %1
  %12 = load i32, ptr %4, align 4, !tbaa !5
  %13 = icmp slt i32 %12, 4
  br i1 %13, label %15, label %14

14:                                               ; preds = %11
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #7
  br label %24

15:                                               ; preds = %11
  %16 = load ptr, ptr %3, align 8, !tbaa !9
  %17 = getelementptr inbounds nuw %struct.GraphNode, ptr %16, i32 0, i32 2
  %18 = load i32, ptr %4, align 4, !tbaa !5
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [4 x ptr], ptr %17, i64 0, i64 %19
  store ptr null, ptr %20, align 8, !tbaa !9
  br label %21

21:                                               ; preds = %15
  %22 = load i32, ptr %4, align 4, !tbaa !5
  %23 = add nsw i32 %22, 1
  store i32 %23, ptr %4, align 4, !tbaa !5
  br label %11, !llvm.loop !15

24:                                               ; preds = %14
  %25 = load ptr, ptr %3, align 8, !tbaa !9
  call void @llvm.lifetime.end.p0(i64 8, ptr %3) #7
  ret ptr %25
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local void @addEdge(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8, !tbaa !9
  store ptr %1, ptr %4, align 8, !tbaa !9
  %5 = load ptr, ptr %3, align 8, !tbaa !9
  %6 = getelementptr inbounds nuw %struct.GraphNode, ptr %5, i32 0, i32 1
  %7 = load i32, ptr %6, align 4, !tbaa !14
  %8 = icmp slt i32 %7, 4
  br i1 %8, label %9, label %19

9:                                                ; preds = %2
  %10 = load ptr, ptr %4, align 8, !tbaa !9
  %11 = load ptr, ptr %3, align 8, !tbaa !9
  %12 = getelementptr inbounds nuw %struct.GraphNode, ptr %11, i32 0, i32 2
  %13 = load ptr, ptr %3, align 8, !tbaa !9
  %14 = getelementptr inbounds nuw %struct.GraphNode, ptr %13, i32 0, i32 1
  %15 = load i32, ptr %14, align 4, !tbaa !14
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr %14, align 4, !tbaa !14
  %17 = sext i32 %15 to i64
  %18 = getelementptr inbounds [4 x ptr], ptr %12, i64 0, i64 %17
  store ptr %10, ptr %18, align 8, !tbaa !9
  br label %19

19:                                               ; preds = %9, %2
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local ptr @createGraph(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  store i32 %0, ptr %2, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 8, ptr %3) #7
  %7 = load i32, ptr %2, align 4, !tbaa !5
  %8 = sext i32 %7 to i64
  %9 = mul i64 %8, 8
  %10 = call noalias ptr @malloc(i64 noundef %9) #8
  store ptr %10, ptr %3, align 8, !tbaa !18
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #7
  store i32 0, ptr %4, align 4, !tbaa !5
  br label %11

11:                                               ; preds = %23, %1
  %12 = load i32, ptr %4, align 4, !tbaa !5
  %13 = load i32, ptr %2, align 4, !tbaa !5
  %14 = icmp slt i32 %12, %13
  br i1 %14, label %16, label %15

15:                                               ; preds = %11
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #7
  br label %26

16:                                               ; preds = %11
  %17 = load i32, ptr %4, align 4, !tbaa !5
  %18 = call ptr @createNode(i32 noundef %17)
  %19 = load ptr, ptr %3, align 8, !tbaa !18
  %20 = load i32, ptr %4, align 4, !tbaa !5
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds ptr, ptr %19, i64 %21
  store ptr %18, ptr %22, align 8, !tbaa !9
  br label %23

23:                                               ; preds = %16
  %24 = load i32, ptr %4, align 4, !tbaa !5
  %25 = add nsw i32 %24, 1
  store i32 %25, ptr %4, align 4, !tbaa !5
  br label %11, !llvm.loop !20

26:                                               ; preds = %15
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #7
  store i32 0, ptr %5, align 4, !tbaa !5
  br label %27

27:                                               ; preds = %94, %26
  %28 = load i32, ptr %5, align 4, !tbaa !5
  %29 = load i32, ptr %2, align 4, !tbaa !5
  %30 = sub nsw i32 %29, 1
  %31 = icmp slt i32 %28, %30
  br i1 %31, label %33, label %32

32:                                               ; preds = %27
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #7
  br label %97

33:                                               ; preds = %27
  %34 = load ptr, ptr %3, align 8, !tbaa !18
  %35 = load i32, ptr %5, align 4, !tbaa !5
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds ptr, ptr %34, i64 %36
  %38 = load ptr, ptr %37, align 8, !tbaa !9
  %39 = load ptr, ptr %3, align 8, !tbaa !18
  %40 = load i32, ptr %5, align 4, !tbaa !5
  %41 = add nsw i32 %40, 1
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds ptr, ptr %39, i64 %42
  %44 = load ptr, ptr %43, align 8, !tbaa !9
  call void @addEdge(ptr noundef %38, ptr noundef %44)
  %45 = load i32, ptr %5, align 4, !tbaa !5
  %46 = icmp sgt i32 %45, 0
  br i1 %46, label %47, label %59

47:                                               ; preds = %33
  %48 = load ptr, ptr %3, align 8, !tbaa !18
  %49 = load i32, ptr %5, align 4, !tbaa !5
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds ptr, ptr %48, i64 %50
  %52 = load ptr, ptr %51, align 8, !tbaa !9
  %53 = load ptr, ptr %3, align 8, !tbaa !18
  %54 = load i32, ptr %5, align 4, !tbaa !5
  %55 = sub nsw i32 %54, 1
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds ptr, ptr %53, i64 %56
  %58 = load ptr, ptr %57, align 8, !tbaa !9
  call void @addEdge(ptr noundef %52, ptr noundef %58)
  br label %59

59:                                               ; preds = %47, %33
  %60 = load i32, ptr %5, align 4, !tbaa !5
  %61 = add nsw i32 %60, 2
  %62 = load i32, ptr %2, align 4, !tbaa !5
  %63 = icmp slt i32 %61, %62
  br i1 %63, label %64, label %76

64:                                               ; preds = %59
  %65 = load ptr, ptr %3, align 8, !tbaa !18
  %66 = load i32, ptr %5, align 4, !tbaa !5
  %67 = sext i32 %66 to i64
  %68 = getelementptr inbounds ptr, ptr %65, i64 %67
  %69 = load ptr, ptr %68, align 8, !tbaa !9
  %70 = load ptr, ptr %3, align 8, !tbaa !18
  %71 = load i32, ptr %5, align 4, !tbaa !5
  %72 = add nsw i32 %71, 2
  %73 = sext i32 %72 to i64
  %74 = getelementptr inbounds ptr, ptr %70, i64 %73
  %75 = load ptr, ptr %74, align 8, !tbaa !9
  call void @addEdge(ptr noundef %69, ptr noundef %75)
  br label %76

76:                                               ; preds = %64, %59
  %77 = load i32, ptr %5, align 4, !tbaa !5
  %78 = add nsw i32 %77, 3
  %79 = load i32, ptr %2, align 4, !tbaa !5
  %80 = icmp slt i32 %78, %79
  br i1 %80, label %81, label %93

81:                                               ; preds = %76
  %82 = load ptr, ptr %3, align 8, !tbaa !18
  %83 = load i32, ptr %5, align 4, !tbaa !5
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds ptr, ptr %82, i64 %84
  %86 = load ptr, ptr %85, align 8, !tbaa !9
  %87 = load ptr, ptr %3, align 8, !tbaa !18
  %88 = load i32, ptr %5, align 4, !tbaa !5
  %89 = add nsw i32 %88, 3
  %90 = sext i32 %89 to i64
  %91 = getelementptr inbounds ptr, ptr %87, i64 %90
  %92 = load ptr, ptr %91, align 8, !tbaa !9
  call void @addEdge(ptr noundef %86, ptr noundef %92)
  br label %93

93:                                               ; preds = %81, %76
  br label %94

94:                                               ; preds = %93
  %95 = load i32, ptr %5, align 4, !tbaa !5
  %96 = add nsw i32 %95, 1
  store i32 %96, ptr %5, align 4, !tbaa !5
  br label %27, !llvm.loop !21

97:                                               ; preds = %32
  call void @llvm.lifetime.start.p0(i64 8, ptr %6) #7
  %98 = load ptr, ptr %3, align 8, !tbaa !18
  %99 = getelementptr inbounds ptr, ptr %98, i64 0
  %100 = load ptr, ptr %99, align 8, !tbaa !9
  store ptr %100, ptr %6, align 8, !tbaa !9
  %101 = load ptr, ptr %3, align 8, !tbaa !18
  call void @free(ptr noundef %101) #7
  %102 = load ptr, ptr %6, align 8, !tbaa !9
  call void @llvm.lifetime.end.p0(i64 8, ptr %6) #7
  call void @llvm.lifetime.end.p0(i64 8, ptr %3) #7
  ret ptr %102
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #3

; Function Attrs: nounwind uwtable
define dso_local i64 @traverseGraph(ptr noundef %0, i32 noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = alloca i64, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i64, align 8
  %11 = alloca i32, align 4
  %12 = alloca ptr, align 8
  store ptr %0, ptr %6, align 8, !tbaa !9
  store i32 %1, ptr %7, align 4, !tbaa !5
  store ptr %2, ptr %8, align 8, !tbaa !22
  store i32 %3, ptr %9, align 4, !tbaa !5
  %13 = load ptr, ptr %6, align 8, !tbaa !9
  %14 = icmp ne ptr %13, null
  br i1 %14, label %15, label %18

15:                                               ; preds = %4
  %16 = load i32, ptr %7, align 4, !tbaa !5
  %17 = icmp sle i32 %16, 0
  br i1 %17, label %18, label %19

18:                                               ; preds = %15, %4
  store i64 0, ptr %5, align 8
  br label %61

19:                                               ; preds = %15
  call void @llvm.lifetime.start.p0(i64 8, ptr %10) #7
  %20 = load ptr, ptr %6, align 8, !tbaa !9
  %21 = getelementptr inbounds nuw %struct.GraphNode, ptr %20, i32 0, i32 0
  %22 = load i32, ptr %21, align 8, !tbaa !12
  %23 = sext i32 %22 to i64
  store i64 %23, ptr %10, align 8, !tbaa !24
  call void @llvm.lifetime.start.p0(i64 4, ptr %11) #7
  store i32 0, ptr %11, align 4, !tbaa !5
  br label %24

24:                                               ; preds = %56, %19
  %25 = load i32, ptr %11, align 4, !tbaa !5
  %26 = load ptr, ptr %6, align 8, !tbaa !9
  %27 = getelementptr inbounds nuw %struct.GraphNode, ptr %26, i32 0, i32 1
  %28 = load i32, ptr %27, align 4, !tbaa !14
  %29 = icmp slt i32 %25, %28
  br i1 %29, label %31, label %30

30:                                               ; preds = %24
  call void @llvm.lifetime.end.p0(i64 4, ptr %11) #7
  br label %59

31:                                               ; preds = %24
  call void @llvm.lifetime.start.p0(i64 8, ptr %12) #7
  %32 = load ptr, ptr %6, align 8, !tbaa !9
  %33 = getelementptr inbounds nuw %struct.GraphNode, ptr %32, i32 0, i32 2
  %34 = load i32, ptr %11, align 4, !tbaa !5
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [4 x ptr], ptr %33, i64 0, i64 %35
  %37 = load ptr, ptr %36, align 8, !tbaa !9
  store ptr %37, ptr %12, align 8, !tbaa !9
  %38 = load ptr, ptr %12, align 8, !tbaa !9
  %39 = icmp ne ptr %38, null
  br i1 %39, label %40, label %55

40:                                               ; preds = %31
  %41 = load ptr, ptr %12, align 8, !tbaa !9
  %42 = getelementptr inbounds nuw %struct.GraphNode, ptr %41, i32 0, i32 0
  %43 = load i32, ptr %42, align 8, !tbaa !12
  %44 = load i32, ptr %9, align 4, !tbaa !5
  %45 = icmp slt i32 %43, %44
  br i1 %45, label %46, label %55

46:                                               ; preds = %40
  %47 = load ptr, ptr %12, align 8, !tbaa !9
  %48 = load i32, ptr %7, align 4, !tbaa !5
  %49 = sub nsw i32 %48, 1
  %50 = load ptr, ptr %8, align 8, !tbaa !22
  %51 = load i32, ptr %9, align 4, !tbaa !5
  %52 = call i64 @traverseGraph(ptr noundef %47, i32 noundef %49, ptr noundef %50, i32 noundef %51)
  %53 = load i64, ptr %10, align 8, !tbaa !24
  %54 = add nsw i64 %53, %52
  store i64 %54, ptr %10, align 8, !tbaa !24
  br label %55

55:                                               ; preds = %46, %40, %31
  call void @llvm.lifetime.end.p0(i64 8, ptr %12) #7
  br label %56

56:                                               ; preds = %55
  %57 = load i32, ptr %11, align 4, !tbaa !5
  %58 = add nsw i32 %57, 1
  store i32 %58, ptr %11, align 4, !tbaa !5
  br label %24, !llvm.loop !26

59:                                               ; preds = %30
  %60 = load i64, ptr %10, align 8, !tbaa !24
  store i64 %60, ptr %5, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr %10) #7
  br label %61

61:                                               ; preds = %59, %18
  %62 = load i64, ptr %5, align 8
  ret i64 %62
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i64, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4, !tbaa !5
  store ptr %1, ptr %5, align 8, !tbaa !27
  call void @llvm.lifetime.start.p0(i64 4, ptr %6) #7
  store i32 1000, ptr %6, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 4, ptr %7) #7
  store i32 100, ptr %7, align 4, !tbaa !5
  %12 = load i32, ptr %4, align 4, !tbaa !5
  %13 = icmp sgt i32 %12, 1
  br i1 %13, label %14, label %19

14:                                               ; preds = %2
  %15 = load ptr, ptr %5, align 8, !tbaa !27
  %16 = getelementptr inbounds ptr, ptr %15, i64 1
  %17 = load ptr, ptr %16, align 8, !tbaa !29
  %18 = call i32 @atoi(ptr noundef %17) #9
  store i32 %18, ptr %6, align 4, !tbaa !5
  br label %19

19:                                               ; preds = %14, %2
  %20 = load i32, ptr %6, align 4, !tbaa !5
  %21 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %20)
  call void @llvm.lifetime.start.p0(i64 8, ptr %8) #7
  %22 = load i32, ptr %6, align 4, !tbaa !5
  %23 = call ptr @createGraph(i32 noundef %22)
  store ptr %23, ptr %8, align 8, !tbaa !9
  %24 = load i32, ptr %7, align 4, !tbaa !5
  %25 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %24)
  call void @llvm.lifetime.start.p0(i64 8, ptr %9) #7
  store i64 0, ptr %9, align 8, !tbaa !24
  call void @llvm.lifetime.start.p0(i64 8, ptr %10) #7
  %26 = load i32, ptr %6, align 4, !tbaa !5
  %27 = sext i32 %26 to i64
  %28 = call noalias ptr @calloc(i64 noundef %27, i64 noundef 4) #10
  store ptr %28, ptr %10, align 8, !tbaa !22
  call void @llvm.lifetime.start.p0(i64 4, ptr %11) #7
  store i32 0, ptr %11, align 4, !tbaa !5
  br label %29

29:                                               ; preds = %41, %19
  %30 = load i32, ptr %11, align 4, !tbaa !5
  %31 = load i32, ptr %7, align 4, !tbaa !5
  %32 = icmp slt i32 %30, %31
  br i1 %32, label %34, label %33

33:                                               ; preds = %29
  call void @llvm.lifetime.end.p0(i64 4, ptr %11) #7
  br label %44

34:                                               ; preds = %29
  %35 = load ptr, ptr %8, align 8, !tbaa !9
  %36 = load ptr, ptr %10, align 8, !tbaa !22
  %37 = load i32, ptr %6, align 4, !tbaa !5
  %38 = call i64 @traverseGraph(ptr noundef %35, i32 noundef 3, ptr noundef %36, i32 noundef %37)
  %39 = load i64, ptr %9, align 8, !tbaa !24
  %40 = add nsw i64 %39, %38
  store i64 %40, ptr %9, align 8, !tbaa !24
  br label %41

41:                                               ; preds = %34
  %42 = load i32, ptr %11, align 4, !tbaa !5
  %43 = add nsw i32 %42, 1
  store i32 %43, ptr %11, align 4, !tbaa !5
  br label %29, !llvm.loop !31

44:                                               ; preds = %33
  %45 = load i64, ptr %9, align 8, !tbaa !24
  %46 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i64 noundef %45)
  %47 = load ptr, ptr %10, align 8, !tbaa !22
  call void @free(ptr noundef %47) #7
  call void @llvm.lifetime.end.p0(i64 8, ptr %10) #7
  call void @llvm.lifetime.end.p0(i64 8, ptr %9) #7
  call void @llvm.lifetime.end.p0(i64 8, ptr %8) #7
  call void @llvm.lifetime.end.p0(i64 4, ptr %7) #7
  call void @llvm.lifetime.end.p0(i64 4, ptr %6) #7
  ret i32 0
}

; Function Attrs: inlinehint nounwind willreturn memory(read) uwtable
define available_externally i32 @atoi(ptr noundef nonnull %0) #4 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8, !tbaa !29
  %3 = load ptr, ptr %2, align 8, !tbaa !29
  %4 = call i64 @strtol(ptr noundef %3, ptr noundef null, i32 noundef 10) #7
  %5 = trunc i64 %4 to i32
  ret i32 %5
}

declare i32 @printf(ptr noundef, ...) #5

; Function Attrs: nounwind allocsize(0,1)
declare noalias ptr @calloc(i64 noundef, i64 noundef) #6

; Function Attrs: nounwind
declare i64 @strtol(ptr noundef, ptr noundef, i32 noundef) #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { inlinehint nounwind willreturn memory(read) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind allocsize(0,1) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nounwind }
attributes #8 = { nounwind allocsize(0) }
attributes #9 = { nounwind willreturn memory(read) }
attributes #10 = { nounwind allocsize(0,1) }

!llvm.ident = !{!0}
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
!10 = !{!"p1 _ZTS9GraphNode", !11, i64 0}
!11 = !{!"any pointer", !7, i64 0}
!12 = !{!13, !6, i64 0}
!13 = !{!"GraphNode", !6, i64 0, !6, i64 4, !7, i64 8}
!14 = !{!13, !6, i64 4}
!15 = distinct !{!15, !16, !17}
!16 = !{!"llvm.loop.mustprogress"}
!17 = !{!"llvm.loop.unroll.disable"}
!18 = !{!19, !19, i64 0}
!19 = !{!"p2 _ZTS9GraphNode", !11, i64 0}
!20 = distinct !{!20, !16, !17}
!21 = distinct !{!21, !16, !17}
!22 = !{!23, !23, i64 0}
!23 = !{!"p1 int", !11, i64 0}
!24 = !{!25, !25, i64 0}
!25 = !{!"long long", !7, i64 0}
!26 = distinct !{!26, !16, !17}
!27 = !{!28, !28, i64 0}
!28 = !{!"p2 omnipotent char", !11, i64 0}
!29 = !{!30, !30, i64 0}
!30 = !{!"p1 omnipotent char", !11, i64 0}
!31 = distinct !{!31, !16, !17}
