; ModuleID = 'Output/linkedList.selective.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Node = type { i32, ptr }

@.str = private unnamed_addr constant [36 x i8] c"Creating linked list with %d nodes\0A\00", align 1
@.str.1 = private unnamed_addr constant [17 x i8] c"Traversing list\0A\00", align 1
@.str.2 = private unnamed_addr constant [10 x i8] c"Sum : %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local ptr @createList(i32 noundef %0) #0 {
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

7:                                                ; preds = %30, %1
  %8 = load i32, ptr %5, align 4, !tbaa !5
  %9 = load i32, ptr %2, align 4, !tbaa !5
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %12, label %11

11:                                               ; preds = %7
  call void @llvm.lifetime.end.p0(i64 4, ptr %5) #7
  br label %33

12:                                               ; preds = %7
  call void @llvm.lifetime.start.p0(i64 8, ptr %6) #7
  %13 = call noalias ptr @malloc(i64 noundef 16) #8
  store ptr %13, ptr %6, align 8, !tbaa !9
  %14 = load i32, ptr %5, align 4, !tbaa !5
  %15 = load ptr, ptr %6, align 8, !tbaa !9
  %rds.field.ptr = getelementptr inbounds %struct.Node, ptr %15, i32 0, i32 1
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %16 = getelementptr inbounds nuw %struct.Node, ptr %15, i32 0, i32 0
  store i32 %14, ptr %16, align 8, !tbaa !12
  %17 = load ptr, ptr %6, align 8, !tbaa !9
  %18 = getelementptr inbounds nuw %struct.Node, ptr %17, i32 0, i32 1
  store ptr null, ptr %18, align 8, !tbaa !14
  %19 = load ptr, ptr %3, align 8, !tbaa !9
  %20 = icmp eq ptr %19, null
  br i1 %20, label %21, label %24

21:                                               ; preds = %12
  %22 = load ptr, ptr %6, align 8, !tbaa !9
  store ptr %22, ptr %3, align 8, !tbaa !9
  %23 = load ptr, ptr %6, align 8, !tbaa !9
  store ptr %23, ptr %4, align 8, !tbaa !9
  br label %29

24:                                               ; preds = %12
  %25 = load ptr, ptr %6, align 8, !tbaa !9
  %26 = load ptr, ptr %4, align 8, !tbaa !9
  %27 = getelementptr inbounds nuw %struct.Node, ptr %26, i32 0, i32 1
  store ptr %25, ptr %27, align 8, !tbaa !14
  %28 = load ptr, ptr %6, align 8, !tbaa !9
  store ptr %28, ptr %4, align 8, !tbaa !9
  br label %29

29:                                               ; preds = %24, %21
  call void @llvm.lifetime.end.p0(i64 8, ptr %6) #7
  br label %30

30:                                               ; preds = %29
  %31 = load i32, ptr %5, align 4, !tbaa !5
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %5, align 4, !tbaa !5
  br label %7, !llvm.loop !15

33:                                               ; preds = %11
  %34 = load ptr, ptr %3, align 8, !tbaa !9
  call void @llvm.lifetime.end.p0(i64 8, ptr %4) #7
  call void @llvm.lifetime.end.p0(i64 8, ptr %3) #7
  ret ptr %34
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: nounwind uwtable
define dso_local i32 @traverseList(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8, !tbaa !9
  call void @llvm.lifetime.start.p0(i64 4, ptr %3) #7
  store i32 0, ptr %3, align 4, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 8, ptr %4) #7
  %5 = load ptr, ptr %2, align 8, !tbaa !9
  store ptr %5, ptr %4, align 8, !tbaa !9
  br label %6

6:                                                ; preds = %9, %1
  %7 = load ptr, ptr %4, align 8, !tbaa !9
  %8 = icmp ne ptr %7, null
  br i1 %8, label %9, label %18

9:                                                ; preds = %6
  %10 = load ptr, ptr %4, align 8, !tbaa !9
  %rds.field.ptr = getelementptr inbounds %struct.Node, ptr %10, i32 0, i32 1
  %rds.field.val = load ptr, ptr %rds.field.ptr, align 8
  call void @llvm.prefetch.p0(ptr %rds.field.val, i32 0, i32 3, i32 1)
  %11 = getelementptr inbounds nuw %struct.Node, ptr %10, i32 0, i32 0
  %12 = load i32, ptr %11, align 8, !tbaa !12
  %13 = load i32, ptr %3, align 4, !tbaa !5
  %14 = add nsw i32 %13, %12
  store i32 %14, ptr %3, align 4, !tbaa !5
  %15 = load ptr, ptr %4, align 8, !tbaa !9
  %16 = getelementptr inbounds nuw %struct.Node, ptr %15, i32 0, i32 1
  %17 = load ptr, ptr %16, align 8, !tbaa !14
  store ptr %17, ptr %4, align 8, !tbaa !9
  br label %6, !llvm.loop !18

18:                                               ; preds = %6
  %19 = load i32, ptr %3, align 4, !tbaa !5
  call void @llvm.lifetime.end.p0(i64 8, ptr %4) #7
  call void @llvm.lifetime.end.p0(i64 4, ptr %3) #7
  ret i32 %19
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
  %11 = getelementptr inbounds nuw %struct.Node, ptr %10, i32 0, i32 1
  %12 = load ptr, ptr %11, align 8, !tbaa !14
  store ptr %12, ptr %4, align 8, !tbaa !9
  %13 = load ptr, ptr %3, align 8, !tbaa !9
  call void @free(ptr noundef %13) #7
  %14 = load ptr, ptr %4, align 8, !tbaa !9
  store ptr %14, ptr %3, align 8, !tbaa !9
  call void @llvm.lifetime.end.p0(i64 8, ptr %4) #7
  br label %6, !llvm.loop !19

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
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4, !tbaa !5
  store ptr %1, ptr %5, align 8, !tbaa !20
  call void @llvm.lifetime.start.p0(i64 4, ptr %6) #7
  store i32 1000, ptr %6, align 4, !tbaa !5
  %9 = load i32, ptr %4, align 4, !tbaa !5
  %10 = icmp sgt i32 %9, 1
  br i1 %10, label %11, label %16

11:                                               ; preds = %2
  %12 = load ptr, ptr %5, align 8, !tbaa !20
  %13 = getelementptr inbounds ptr, ptr %12, i64 1
  %14 = load ptr, ptr %13, align 8, !tbaa !22
  %15 = call i32 @atoi(ptr noundef %14) #9
  store i32 %15, ptr %6, align 4, !tbaa !5
  br label %16

16:                                               ; preds = %11, %2
  %17 = load i32, ptr %6, align 4, !tbaa !5
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %17)
  call void @llvm.lifetime.start.p0(i64 8, ptr %7) #7
  %19 = load i32, ptr %6, align 4, !tbaa !5
  %20 = call ptr @createList(i32 noundef %19)
  store ptr %20, ptr %7, align 8, !tbaa !9
  %21 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  call void @llvm.lifetime.start.p0(i64 4, ptr %8) #7
  %22 = load ptr, ptr %7, align 8, !tbaa !9
  %23 = call i32 @traverseList(ptr noundef %22)
  store i32 %23, ptr %8, align 4, !tbaa !5
  %24 = load i32, ptr %8, align 4, !tbaa !5
  %25 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %24)
  %26 = load ptr, ptr %7, align 8, !tbaa !9
  call void @freeList(ptr noundef %26)
  call void @llvm.lifetime.end.p0(i64 4, ptr %8) #7
  call void @llvm.lifetime.end.p0(i64 8, ptr %7) #7
  call void @llvm.lifetime.end.p0(i64 4, ptr %6) #7
  ret i32 0
}

; Function Attrs: inlinehint nounwind willreturn memory(read) uwtable
define available_externally i32 @atoi(ptr noundef nonnull %0) #4 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8, !tbaa !22
  %3 = load ptr, ptr %2, align 8, !tbaa !22
  %4 = call i64 @strtol(ptr noundef %3, ptr noundef null, i32 noundef 10) #7
  %5 = trunc i64 %4 to i32
  ret i32 %5
}

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
!13 = !{!"Node", !6, i64 0, !10, i64 8}
!14 = !{!13, !10, i64 8}
!15 = distinct !{!15, !16, !17}
!16 = !{!"llvm.loop.mustprogress"}
!17 = !{!"llvm.loop.unroll.disable"}
!18 = distinct !{!18, !16, !17}
!19 = distinct !{!19, !16, !17}
!20 = !{!21, !21, i64 0}
!21 = !{!"p2 omnipotent char", !11, i64 0}
!22 = !{!23, !23, i64 0}
!23 = !{!"p1 omnipotent char", !11, i64 0}
