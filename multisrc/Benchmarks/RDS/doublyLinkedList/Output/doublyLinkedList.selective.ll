; ModuleID = 'Output/doublyLinkedList.selective.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Node = type { i32, ptr, ptr }

@.str = private unnamed_addr constant [43 x i8] c"Creating doubly linked list with %d nodes\0A\00", align 1
@.str.1 = private unnamed_addr constant [34 x i8] c"Performing %d forward traversals\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"Result : %lld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local ptr @createDoublyLinkedList(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  store i32 %0, ptr %2, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 8, ptr %3) #7
  store ptr null, ptr %3, align 8, !tbaa !9
  call void @llvm.lifetime.start.p0(i64 8, ptr %4) #7
  store ptr null, ptr %4, align 8, !tbaa !9
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #7
  store i32 0, ptr %5, align 4, !tbaa !5
  br label %7

7:                                                ; preds = %32, %1
  %8 = load i32, ptr %5, align 4, !tbaa !5
  %9 = load i32, ptr %2, align 4, !tbaa !5
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %12, label %11

11:                                               ; preds = %7
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #7
  br label %35

12:                                               ; preds = %7
  call void @llvm.lifetime.start.p0(i64 8, ptr %6) #7
  %13 = call noalias ptr @malloc(i64 noundef 24) #8
  store ptr %13, ptr %6, align 8, !tbaa !9
  %14 = load i32, ptr %5, align 4, !tbaa !5
  %15 = load ptr, ptr %6, align 8, !tbaa !9
  %rds.field.ptr = getelementptr inbounds %struct.Node, ptr %15, i32 0, i32 1
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %rds.field.ptr1 = getelementptr inbounds %struct.Node, ptr %15, i32 0, i32 2
  %rds.field.val2 = load ptr, ptr %rds.field.ptr1, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val2, i32 0, i32 3, i32 1)
  %16 = getelementptr inbounds nuw %struct.Node, ptr %15, i32 0, i32 0
  store i32 %14, ptr %16, align 8, !tbaa !12
  %17 = load ptr, ptr %6, align 8, !tbaa !9
  %18 = getelementptr inbounds nuw %struct.Node, ptr %17, i32 0, i32 1
  store ptr null, ptr %18, align 8, !tbaa !14
  %19 = load ptr, ptr %4, align 8, !tbaa !9
  %20 = load ptr, ptr %6, align 8, !tbaa !9
  %21 = getelementptr inbounds nuw %struct.Node, ptr %20, i32 0, i32 2
  store ptr %19, ptr %21, align 8, !tbaa !15
  %22 = load ptr, ptr %3, align 8, !tbaa !9
  %23 = icmp eq ptr %22, null
  br i1 %23, label %24, label %26

24:                                               ; preds = %12
  %25 = load ptr, ptr %6, align 8, !tbaa !9
  store ptr %25, ptr %3, align 8, !tbaa !9
  br label %30

26:                                               ; preds = %12
  %27 = load ptr, ptr %6, align 8, !tbaa !9
  %28 = load ptr, ptr %4, align 8, !tbaa !9
  %rds.field.ptr3 = getelementptr inbounds %struct.Node, ptr %28, i32 0, i32 2
  %rds.field.val4 = load ptr, ptr %rds.field.ptr3, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val4, i32 0, i32 3, i32 1)
  %29 = getelementptr inbounds nuw %struct.Node, ptr %28, i32 0, i32 1
  store ptr %27, ptr %29, align 8, !tbaa !14
  br label %30

30:                                               ; preds = %26, %24
  %31 = load ptr, ptr %6, align 8, !tbaa !9
  store ptr %31, ptr %4, align 8, !tbaa !9
  call void @llvm.lifetime.end.p0(i64 8, ptr %6) #7
  br label %32

32:                                               ; preds = %30
  %33 = load i32, ptr %5, align 4, !tbaa !5
  %34 = add nsw i32 %33, 1
  store i32 %34, ptr %5, align 4, !tbaa !5
  br label %7, !llvm.loop !16

35:                                               ; preds = %11
  %36 = load ptr, ptr %3, align 8, !tbaa !9
  call void @llvm.lifetime.end.p0(i64 8, ptr %4) #7
  call void @llvm.lifetime.end.p0(i64 8, ptr %3) #7
  ret ptr %36
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: nounwind uwtable
define dso_local i64 @forwardTraversal(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 8, !tbaa !9
  call void @llvm.lifetime.start.p0(i64 8, ptr %3) #7
  store i64 0, ptr %3, align 8, !tbaa !19
  call void @llvm.lifetime.start.p0(i64 8, ptr %4) #7
  %6 = load ptr, ptr %2, align 8, !tbaa !9
  store ptr %6, ptr %4, align 8, !tbaa !9
  br label %7

7:                                                ; preds = %34, %1
  %8 = load ptr, ptr %4, align 8, !tbaa !9
  %9 = icmp ne ptr %8, null
  br i1 %9, label %10, label %38

10:                                               ; preds = %7
  %11 = load ptr, ptr %4, align 8, !tbaa !9
  %rds.field.ptr = getelementptr inbounds %struct.Node, ptr %11, i32 0, i32 1
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %rds.field.ptr1 = getelementptr inbounds %struct.Node, ptr %11, i32 0, i32 2
  %rds.field.val2 = load ptr, ptr %rds.field.ptr1, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val2, i32 0, i32 3, i32 1)
  %12 = getelementptr inbounds nuw %struct.Node, ptr %11, i32 0, i32 0
  %13 = load i32, ptr %12, align 8, !tbaa !12
  %14 = sext i32 %13 to i64
  %15 = load i64, ptr %3, align 8, !tbaa !19
  %16 = add nsw i64 %15, %14
  store i64 %16, ptr %3, align 8, !tbaa !19
  call void @llvm.lifetime.start.p0(i64 4, ptr %5) #7
  store i32 0, ptr %5, align 4, !tbaa !5
  br label %17

17:                                               ; preds = %31, %10
  %18 = load i32, ptr %5, align 4, !tbaa !5
  %19 = icmp slt i32 %18, 10
  br i1 %19, label %21, label %20

20:                                               ; preds = %17
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #7
  br label %34

21:                                               ; preds = %17
  %22 = load ptr, ptr %4, align 8, !tbaa !9
  %rds.field.ptr5 = getelementptr inbounds %struct.Node, ptr %22, i32 0, i32 1
  %rds.field.val6 = load ptr, ptr %rds.field.ptr5, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val6, i32 0, i32 3, i32 1)
  %rds.field.ptr7 = getelementptr inbounds %struct.Node, ptr %22, i32 0, i32 2
  %rds.field.val8 = load ptr, ptr %rds.field.ptr7, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val8, i32 0, i32 3, i32 1)
  %23 = getelementptr inbounds nuw %struct.Node, ptr %22, i32 0, i32 0
  %24 = load i32, ptr %23, align 8, !tbaa !12
  %25 = load i32, ptr %5, align 4, !tbaa !5
  %26 = add nsw i32 %25, 1
  %27 = mul nsw i32 %24, %26
  %28 = sext i32 %27 to i64
  %29 = load i64, ptr %3, align 8, !tbaa !19
  %30 = add nsw i64 %29, %28
  store i64 %30, ptr %3, align 8, !tbaa !19
  br label %31

31:                                               ; preds = %21
  %32 = load i32, ptr %5, align 4, !tbaa !5
  %33 = add nsw i32 %32, 1
  store i32 %33, ptr %5, align 4, !tbaa !5
  br label %17, !llvm.loop !21

34:                                               ; preds = %20
  %35 = load ptr, ptr %4, align 8, !tbaa !9
  %rds.field.ptr3 = getelementptr inbounds %struct.Node, ptr %35, i32 0, i32 2
  %rds.field.val4 = load ptr, ptr %rds.field.ptr3, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val4, i32 0, i32 3, i32 1)
  %36 = getelementptr inbounds nuw %struct.Node, ptr %35, i32 0, i32 1
  %37 = load ptr, ptr %36, align 8, !tbaa !14
  store ptr %37, ptr %4, align 8, !tbaa !9
  br label %7, !llvm.loop !22

38:                                               ; preds = %7
  %39 = load i64, ptr %3, align 8, !tbaa !19
  call void @llvm.lifetime.end.p0(i64 8, ptr %4) #7
  call void @llvm.lifetime.end.p0(i64 8, ptr %3) #7
  ret i64 %39
}

; Function Attrs: nounwind uwtable
define dso_local i64 @multiTraversal(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 8, !tbaa !9
  store i32 %1, ptr %4, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 8, ptr %5) #7
  store i64 0, ptr %5, align 8, !tbaa !19
  call void @llvm.lifetime.start.p0(i64 4, ptr %6) #7
  store i32 0, ptr %6, align 4, !tbaa !5
  br label %7

7:                                                ; preds = %17, %2
  %8 = load i32, ptr %6, align 4, !tbaa !5
  %9 = load i32, ptr %4, align 4, !tbaa !5
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %12, label %11

11:                                               ; preds = %7
  call void @llvm.lifetime.end.p0(i64 4, ptr %6) #7
  br label %20

12:                                               ; preds = %7
  %13 = load ptr, ptr %3, align 8, !tbaa !9
  %14 = call i64 @forwardTraversal(ptr noundef %13)
  %15 = load i64, ptr %5, align 8, !tbaa !19
  %16 = add nsw i64 %15, %14
  store i64 %16, ptr %5, align 8, !tbaa !19
  br label %17

17:                                               ; preds = %12
  %18 = load i32, ptr %6, align 4, !tbaa !5
  %19 = add nsw i32 %18, 1
  store i32 %19, ptr %6, align 4, !tbaa !5
  br label %7, !llvm.loop !23

20:                                               ; preds = %11
  %21 = load i64, ptr %5, align 8, !tbaa !19
  call void @llvm.lifetime.end.p0(i64 8, ptr %5) #7
  ret i64 %21
}

; Function Attrs: nounwind uwtable
define dso_local void @freeList(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8, !tbaa !9
  call void @llvm.lifetime.start.p0(i64 8, ptr %3) #7
  %5 = load ptr, ptr %2, align 8, !tbaa !9
  store ptr %5, ptr %3, align 8, !tbaa !9
  br label %6

6:                                                ; preds = %9, %1
  %7 = load ptr, ptr %3, align 8, !tbaa !9
  %8 = icmp ne ptr %7, null
  br i1 %8, label %9, label %15

9:                                                ; preds = %6
  call void @llvm.lifetime.start.p0(i64 8, ptr %4) #7
  %10 = load ptr, ptr %3, align 8, !tbaa !9
  %rds.field.ptr = getelementptr inbounds %struct.Node, ptr %10, i32 0, i32 2
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %11 = getelementptr inbounds nuw %struct.Node, ptr %10, i32 0, i32 1
  %12 = load ptr, ptr %11, align 8, !tbaa !14
  store ptr %12, ptr %4, align 8, !tbaa !9
  %13 = load ptr, ptr %3, align 8, !tbaa !9
  call void @free(ptr noundef %13) #7
  %14 = load ptr, ptr %4, align 8, !tbaa !9
  store ptr %14, ptr %3, align 8, !tbaa !9
  call void @llvm.lifetime.end.p0(i64 8, ptr %4) #7
  br label %6, !llvm.loop !24

15:                                               ; preds = %6
  call void @llvm.lifetime.end.p0(i64 8, ptr %3) #7
  ret void
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #3

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i64, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4, !tbaa !5
  store ptr %1, ptr %5, align 8, !tbaa !25
  call void @llvm.lifetime.start.p0(i64 4, ptr %6) #7
  store i32 10000, ptr %6, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 4, ptr %7) #7
  store i32 100, ptr %7, align 4, !tbaa !5
  %10 = load i32, ptr %4, align 4, !tbaa !5
  %11 = icmp sgt i32 %10, 1
  br i1 %11, label %12, label %17

12:                                               ; preds = %2
  %13 = load ptr, ptr %5, align 8, !tbaa !25
  %14 = getelementptr inbounds ptr, ptr %13, i64 1
  %15 = load ptr, ptr %14, align 8, !tbaa !27
  %16 = call i32 @atoi(ptr noundef %15) #9
  store i32 %16, ptr %6, align 4, !tbaa !5
  br label %17

17:                                               ; preds = %12, %2
  %18 = load i32, ptr %4, align 4, !tbaa !5
  %19 = icmp sgt i32 %18, 2
  br i1 %19, label %20, label %25

20:                                               ; preds = %17
  %21 = load ptr, ptr %5, align 8, !tbaa !25
  %22 = getelementptr inbounds ptr, ptr %21, i64 2
  %23 = load ptr, ptr %22, align 8, !tbaa !27
  %24 = call i32 @atoi(ptr noundef %23) #9
  store i32 %24, ptr %7, align 4, !tbaa !5
  br label %25

25:                                               ; preds = %20, %17
  %26 = call i64 @time(ptr noundef null) #7
  %27 = trunc i64 %26 to i32
  call void @srand(i32 noundef %27) #7
  %28 = load i32, ptr %6, align 4, !tbaa !5
  %29 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %28)
  call void @llvm.lifetime.start.p0(i64 8, ptr %8) #7
  %30 = load i32, ptr %6, align 4, !tbaa !5
  %31 = call ptr @createDoublyLinkedList(i32 noundef %30)
  store ptr %31, ptr %8, align 8, !tbaa !9
  %32 = load i32, ptr %7, align 4, !tbaa !5
  %33 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %32)
  call void @llvm.lifetime.start.p0(i64 8, ptr %9) #7
  %34 = load ptr, ptr %8, align 8, !tbaa !9
  %35 = load i32, ptr %7, align 4, !tbaa !5
  %36 = call i64 @multiTraversal(ptr noundef %34, i32 noundef %35)
  store i64 %36, ptr %9, align 8, !tbaa !19
  %37 = load i64, ptr %9, align 8, !tbaa !19
  %38 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i64 noundef %37)
  %39 = load ptr, ptr %8, align 8, !tbaa !9
  call void @freeList(ptr noundef %39)
  call void @llvm.lifetime.end.p0(i64 8, ptr %9) #7
  call void @llvm.lifetime.end.p0(i64 8, ptr %8) #7
  call void @llvm.lifetime.end.p0(i64 4, ptr %7) #7
  call void @llvm.lifetime.end.p0(i64 4, ptr %6) #7
  ret i32 0
}

; Function Attrs: inlinehint nounwind willreturn memory(read) uwtable
define available_externally i32 @atoi(ptr noundef nonnull %0) #4 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8, !tbaa !27
  %3 = load ptr, ptr %2, align 8, !tbaa !27
  %4 = call i64 @strtol(ptr noundef %3, ptr noundef null, i32 noundef 10) #7
  %5 = trunc i64 %4 to i32
  ret i32 %5
}

; Function Attrs: nounwind
declare i64 @time(ptr noundef) #3

; Function Attrs: nounwind
declare void @srand(i32 noundef) #3

declare i32 @printf(ptr noundef, ...) #5

; Function Attrs: nounwind
declare i64 @strtol(ptr noundef, ptr noundef, i32 noundef) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @llvm.prefetch.p0(ptr nocapture readonly, i32 immarg, i32 immarg, i32 immarg) #6

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { inlinehint nounwind willreturn memory(read) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite) }
attributes #7 = { nounwind }
attributes #8 = { nounwind allocsize(0) }
attributes #9 = { nounwind willreturn memory(read) }

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
!10 = !{!"p1 _ZTS4Node", !11, i64 0}
!11 = !{!"any pointer", !7, i64 0}
!12 = !{!13, !6, i64 0}
!13 = !{!"Node", !6, i64 0, !10, i64 8, !10, i64 16}
!14 = !{!13, !10, i64 8}
!15 = !{!13, !10, i64 16}
!16 = distinct !{!16, !17, !18}
!17 = !{!"llvm.loop.mustprogress"}
!18 = !{!"llvm.loop.unroll.disable"}
!19 = !{!20, !20, i64 0}
!20 = !{!"long long", !7, i64 0}
!21 = distinct !{!21, !17, !18}
!22 = distinct !{!22, !17, !18}
!23 = distinct !{!23, !17, !18}
!24 = distinct !{!24, !17, !18}
!25 = !{!26, !26, i64 0}
!26 = !{!"p2 omnipotent char", !11, i64 0}
!27 = !{!28, !28, i64 0}
!28 = !{!"p1 omnipotent char", !11, i64 0}
