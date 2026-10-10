.class public Lcom/bedoig/BTmono/MicKeeper;
.super Ljava/lang/Object;
.source "MicKeeper.java"

# static fields
.field public static isRunning:Z = false

.field public static audioRecord:Landroid/media/AudioRecord; = null

.field private static thread:Ljava/lang/Thread; = null


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    sput-boolean v0, Lcom/bedoig/BTmono/MicKeeper;->isRunning:Z

    const/4 v0, 0x0

    sput-object v0, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;

    sput-object v0, Lcom/bedoig/BTmono/MicKeeper;->thread:Ljava/lang/Thread;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized start(Landroid/content/Context;)V
    .locals 3

    const-class v0, Lcom/bedoig/BTmono/MicKeeper;

    monitor-enter v0

    :try_start_0
    sget-boolean v1, Lcom/bedoig/BTmono/MicKeeper;->isRunning:Z
    if-eqz v1, :cond_0

    monitor-exit v0
    return-void

    :cond_0
    const/4 v1, 0x1
    sput-boolean v1, Lcom/bedoig/BTmono/MicKeeper;->isRunning:Z

    new-instance v1, Lcom/bedoig/BTmono/MicKeeper$1;

    invoke-direct {v1, p0}, Lcom/bedoig/BTmono/MicKeeper$1;-><init>(Landroid/content/Context;)V

    sput-object v1, Lcom/bedoig/BTmono/MicKeeper;->thread:Ljava/lang/Thread;

    sget-object v1, Lcom/bedoig/BTmono/MicKeeper;->thread:Ljava/lang/Thread;

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0
    return-void

    :catchall_0
    move-exception v1
    monitor-exit v0
    throw v1
.end method

.method public static declared-synchronized stop(Landroid/content/Context;)V
    .locals 3

    const-class v0, Lcom/bedoig/BTmono/MicKeeper;

    monitor-enter v0

    :try_start_0
    const/4 v1, 0x0

    sput-boolean v1, Lcom/bedoig/BTmono/MicKeeper;->isRunning:Z

    sget-object v1, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    :try_start_1
    sget-object v1, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;

    invoke-virtual {v1}, Landroid/media/AudioRecord;->stop()V

    sget-object v1, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;

    invoke-virtual {v1}, Landroid/media/AudioRecord;->release()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catch_0
    const/4 v1, 0x0
    :try_start_2
    sput-object v1, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;

    :cond_0
    const/4 v1, 0x0

    sput-object v1, Lcom/bedoig/BTmono/MicKeeper;->thread:Ljava/lang/Thread;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit v0
    return-void

    :catchall_0
    move-exception v1
    monitor-exit v0
    throw v1
.end method
