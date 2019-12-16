# GCDDemo
#### 同步与异步、串行与并行；
* 同步与异步调度：dispatch_sync与dispatch_async；
* 串行与并行队列：serial（自定义，main queue）与concurrent（自定义，global queue）；

#### 线程同步
* dispatch_after;延迟异步调度；
* dispatch_group：dispatch_group_t、dispatch_group_enter、dispatch_group_leave、dispatch_group_notify、dispatch_group_wait；
* dispatch_semaphore：dispatch_semaphore_t、dispatch_semaphore_wait、dispatch_semaphore_signal；
* dispatch_barrier_async：对多个异步并发任务的栅栏效果；
* dispatch_apply：对多个类似异步任务并发执行后的同步；

#### 死锁与锁的使用
* 死锁例子
* 同步锁：dispatch_semaphore、@synchronized、NSLock
