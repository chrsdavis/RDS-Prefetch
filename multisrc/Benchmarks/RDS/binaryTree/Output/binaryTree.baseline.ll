; ModuleID = 'Output/binaryTree.linked.rbc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.TreeNode = type { i32, ptr, ptr }

@.str = private unnamed_addr constant [43 x i8] c"Creating binary search tree with %d nodes\0A\00", align 1
@.str.1 = private unnamed_addr constant [39 x i8] c"Computing sum with preorder traversal\0A\00", align 1
@.str.2 = private unnamed_addr constant [10 x i8] c"Sum : %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local ptr @createNode(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  store i32 %0, ptr %2, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 8, ptr %3) #6
  %4 = call noalias ptr @malloc(i64 noundef 24) #7
  store ptr %4, ptr %3, align 8, !tbaa !9
  %5 = load i32, ptr %2, align 4, !tbaa !5
  %6 = load ptr, ptr %3, align 8, !tbaa !9
  %7 = getelementptr inbounds nuw %struct.TreeNode, ptr %6, i32 0, i32 0
  store i32 %5, ptr %7, align 8, !tbaa !12
  %8 = load ptr, ptr %3, align 8, !tbaa !9
  %9 = getelementptr inbounds nuw %struct.TreeNode, ptr %8, i32 0, i32 1
  store ptr null, ptr %9, align 8, !tbaa !14
  %10 = load ptr, ptr %3, align 8, !tbaa !9
  %11 = getelementptr inbounds nuw %struct.TreeNode, ptr %10, i32 0, i32 2
  store ptr null, ptr %11, align 8, !tbaa !15
  %12 = load ptr, ptr %3, align 8, !tbaa !9
  call void @llvm.lifetime.end.p0(i64 8, ptr %3) #6
  ret ptr %12
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local ptr @insertNode(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store ptr %0, ptr %4, align 8, !tbaa !9
  store i32 %1, ptr %5, align 4, !tbaa !5
  %6 = load ptr, ptr %4, align 8, !tbaa !9
  %7 = icmp eq ptr %6, null
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load i32, ptr %5, align 4, !tbaa !5
  %10 = call ptr @createNode(i32 noundef %9)
  store ptr %10, ptr %3, align 8
  br label %35

11:                                               ; preds = %2
  %12 = load i32, ptr %5, align 4, !tbaa !5
  %13 = load ptr, ptr %4, align 8, !tbaa !9
  %14 = getelementptr inbounds nuw %struct.TreeNode, ptr %13, i32 0, i32 0
  %15 = load i32, ptr %14, align 8, !tbaa !12
  %16 = icmp slt i32 %12, %15
  br i1 %16, label %17, label %25

17:                                               ; preds = %11
  %18 = load ptr, ptr %4, align 8, !tbaa !9
  %19 = getelementptr inbounds nuw %struct.TreeNode, ptr %18, i32 0, i32 1
  %20 = load ptr, ptr %19, align 8, !tbaa !14
  %21 = load i32, ptr %5, align 4, !tbaa !5
  %22 = call ptr @insertNode(ptr noundef %20, i32 noundef %21)
  %23 = load ptr, ptr %4, align 8, !tbaa !9
  %24 = getelementptr inbounds nuw %struct.TreeNode, ptr %23, i32 0, i32 1
  store ptr %22, ptr %24, align 8, !tbaa !14
  br label %33

25:                                               ; preds = %11
  %26 = load ptr, ptr %4, align 8, !tbaa !9
  %27 = getelementptr inbounds nuw %struct.TreeNode, ptr %26, i32 0, i32 2
  %28 = load ptr, ptr %27, align 8, !tbaa !15
  %29 = load i32, ptr %5, align 4, !tbaa !5
  %30 = call ptr @insertNode(ptr noundef %28, i32 noundef %29)
  %31 = load ptr, ptr %4, align 8, !tbaa !9
  %32 = getelementptr inbounds nuw %struct.TreeNode, ptr %31, i32 0, i32 2
  store ptr %30, ptr %32, align 8, !tbaa !15
  br label %33

33:                                               ; preds = %25, %17
  %34 = load ptr, ptr %4, align 8, !tbaa !9
  store ptr %34, ptr %3, align 8
  br label %35

35:                                               ; preds = %33, %8
  %36 = load ptr, ptr %3, align 8
  ret ptr %36
}

; Function Attrs: nounwind uwtable
define dso_local i32 @preorderSum(ptr noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8, !tbaa !9
  %5 = load ptr, ptr %3, align 8, !tbaa !9
  %6 = icmp eq ptr %5, null
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  store i32 0, ptr %2, align 4
  br label %25

8:                                                ; preds = %1
  call void @llvm.lifetime.start.p0(i64 4, ptr %4) #6
  %9 = load ptr, ptr %3, align 8, !tbaa !9
  %10 = getelementptr inbounds nuw %struct.TreeNode, ptr %9, i32 0, i32 0
  %11 = load i32, ptr %10, align 8, !tbaa !12
  store i32 %11, ptr %4, align 4, !tbaa !5
  %12 = load ptr, ptr %3, align 8, !tbaa !9
  %13 = getelementptr inbounds nuw %struct.TreeNode, ptr %12, i32 0, i32 1
  %14 = load ptr, ptr %13, align 8, !tbaa !14
  %15 = call i32 @preorderSum(ptr noundef %14)
  %16 = load i32, ptr %4, align 4, !tbaa !5
  %17 = add nsw i32 %16, %15
  store i32 %17, ptr %4, align 4, !tbaa !5
  %18 = load ptr, ptr %3, align 8, !tbaa !9
  %19 = getelementptr inbounds nuw %struct.TreeNode, ptr %18, i32 0, i32 2
  %20 = load ptr, ptr %19, align 8, !tbaa !15
  %21 = call i32 @preorderSum(ptr noundef %20)
  %22 = load i32, ptr %4, align 4, !tbaa !5
  %23 = add nsw i32 %22, %21
  store i32 %23, ptr %4, align 4, !tbaa !5
  %24 = load i32, ptr %4, align 4, !tbaa !5
  store i32 %24, ptr %2, align 4
  call void @llvm.lifetime.end.p0(i64 4, ptr %4) #6
  br label %25

25:                                               ; preds = %8, %7
  %26 = load i32, ptr %2, align 4
  ret i32 %26
}

; Function Attrs: nounwind uwtable
define dso_local void @freeTree(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8, !tbaa !9
  %3 = load ptr, ptr %2, align 8, !tbaa !9
  %4 = icmp eq ptr %3, null
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %14

6:                                                ; preds = %1
  %7 = load ptr, ptr %2, align 8, !tbaa !9
  %8 = getelementptr inbounds nuw %struct.TreeNode, ptr %7, i32 0, i32 1
  %9 = load ptr, ptr %8, align 8, !tbaa !14
  call void @freeTree(ptr noundef %9)
  %10 = load ptr, ptr %2, align 8, !tbaa !9
  %11 = getelementptr inbounds nuw %struct.TreeNode, ptr %10, i32 0, i32 2
  %12 = load ptr, ptr %11, align 8, !tbaa !15
  call void @freeTree(ptr noundef %12)
  %13 = load ptr, ptr %2, align 8, !tbaa !9
  call void @free(ptr noundef %13) #6
  br label %14

14:                                               ; preds = %6, %5
  ret void
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #3

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4, !tbaa !5
  store ptr %1, ptr %5, align 8, !tbaa !16
  call void @llvm.lifetime.start.p0(i64 8, ptr %6) #6
  store ptr null, ptr %6, align 8, !tbaa !9
  call void @llvm.lifetime.start.p0(i64 4, ptr %7) #6
  store i32 1000, ptr %7, align 4, !tbaa !5
  %10 = load i32, ptr %4, align 4, !tbaa !5
  %11 = icmp sgt i32 %10, 1
  br i1 %11, label %12, label %17

12:                                               ; preds = %2
  %13 = load ptr, ptr %5, align 8, !tbaa !16
  %14 = getelementptr inbounds ptr, ptr %13, i64 1
  %15 = load ptr, ptr %14, align 8, !tbaa !18
  %16 = call i32 @atoi(ptr noundef %15) #8
  store i32 %16, ptr %7, align 4, !tbaa !5
  br label %17

17:                                               ; preds = %12, %2
  %18 = load i32, ptr %7, align 4, !tbaa !5
  %19 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %18)
  call void @llvm.lifetime.start.p0(i64 4, ptr %8) #6
  store i32 0, ptr %8, align 4, !tbaa !5
  br label %20

20:                                               ; preds = %32, %17
  %21 = load i32, ptr %8, align 4, !tbaa !5
  %22 = load i32, ptr %7, align 4, !tbaa !5
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %25, label %24

24:                                               ; preds = %20
  call void @llvm.lifetime.end.p0(i64 4, ptr %8) #6
  br label %35

25:                                               ; preds = %20
  %26 = load ptr, ptr %6, align 8, !tbaa !9
  %27 = load i32, ptr %8, align 4, !tbaa !5
  %28 = mul nsw i32 %27, 17
  %29 = add nsw i32 %28, 13
  %30 = srem i32 %29, 1000
  %31 = call ptr @insertNode(ptr noundef %26, i32 noundef %30)
  store ptr %31, ptr %6, align 8, !tbaa !9
  br label %32

32:                                               ; preds = %25
  %33 = load i32, ptr %8, align 4, !tbaa !5
  %34 = add nsw i32 %33, 1
  store i32 %34, ptr %8, align 4, !tbaa !5
  br label %20, !llvm.loop !20

35:                                               ; preds = %24
  %36 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  call void @llvm.lifetime.start.p0(i64 4, ptr %9) #6
  %37 = load ptr, ptr %6, align 8, !tbaa !9
  %38 = call i32 @preorderSum(ptr noundef %37)
  store i32 %38, ptr %9, align 4, !tbaa !5
  %39 = load i32, ptr %9, align 4, !tbaa !5
  %40 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %39)
  %41 = load ptr, ptr %6, align 8, !tbaa !9
  call void @freeTree(ptr noundef %41)
  call void @llvm.lifetime.end.p0(i64 4, ptr %9) #6
  call void @llvm.lifetime.end.p0(i64 4, ptr %7) #6
  call void @llvm.lifetime.end.p0(i64 8, ptr %6) #6
  ret i32 0
}

; Function Attrs: inlinehint nounwind willreturn memory(read) uwtable
define available_externally i32 @atoi(ptr noundef nonnull %0) #4 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8, !tbaa !18
  %3 = load ptr, ptr %2, align 8, !tbaa !18
  %4 = call i64 @strtol(ptr noundef %3, ptr noundef null, i32 noundef 10) #6
  %5 = trunc i64 %4 to i32
  ret i32 %5
}

declare i32 @printf(ptr noundef, ...) #5

; Function Attrs: nounwind
declare i64 @strtol(ptr noundef, ptr noundef, i32 noundef) #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { inlinehint nounwind willreturn memory(read) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind }
attributes #7 = { nounwind allocsize(0) }
attributes #8 = { nounwind willreturn memory(read) }

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
!10 = !{!"p1 _ZTS8TreeNode", !11, i64 0}
!11 = !{!"any pointer", !7, i64 0}
!12 = !{!13, !6, i64 0}
!13 = !{!"TreeNode", !6, i64 0, !10, i64 8, !10, i64 16}
!14 = !{!13, !10, i64 8}
!15 = !{!13, !10, i64 16}
!16 = !{!17, !17, i64 0}
!17 = !{!"p2 omnipotent char", !11, i64 0}
!18 = !{!19, !19, i64 0}
!19 = !{!"p1 omnipotent char", !11, i64 0}
!20 = distinct !{!20, !21, !22}
!21 = !{!"llvm.loop.mustprogress"}
!22 = !{!"llvm.loop.unroll.disable"}
