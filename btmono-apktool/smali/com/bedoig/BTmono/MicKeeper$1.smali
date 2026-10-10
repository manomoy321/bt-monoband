.class final Lcom/bedoig/BTmono/MicKeeper$1;
.super Ljava/lang/Thread;
.source "MicKeeper.java"

# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/bedoig/BTmono/MicKeeper;->start(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

# instance fields
.field final synthetic val$context:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lcom/bedoig/BTmono/MicKeeper$1;->val$context:Landroid/content/Context;

    const-string p1, "BT-Mono-MicKeeper"

    invoke-direct {p0, p1}, Ljava/lang/Thread;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    :try_start_0
    iget-object v0, p0, Lcom/bedoig/BTmono/MicKeeper$1;->val$context:Landroid/content/Context;

    const-string v1, "audio"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/AudioManager;

    if-eqz v0, :cond_1

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1f

    if-lt v1, v2, :cond_1

    invoke-virtual {v0}, Landroid/media/AudioManager;->getAvailableCommunicationDevices()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/media/AudioDeviceInfo;

    invoke-virtual {v2}, Landroid/media/AudioDeviceInfo;->getType()I

    move-result v3

    const/4 v4, 0x7

    if-eq v3, v4, :cond_dev_match

    const/16 v4, 0x1a

    if-ne v3, v4, :cond_0

    :cond_dev_match
    invoke-virtual {v0, v2}, Landroid/media/AudioManager;->setCommunicationDevice(Landroid/media/AudioDeviceInfo;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_comm

    :catch_comm
    :cond_1
    const/16 v3, 0x1f40

    const/16 v4, 0x10

    const/4 v5, 0x2

    :try_start_1
    invoke-static {v3, v4, v5}, Landroid/media/AudioRecord;->getMinBufferSize(III)I

    move-result v0

    if-gtz v0, :cond_2

    const/16 v0, 0x400

    :cond_2
    mul-int/lit8 v6, v0, 0x2

    new-instance v1, Landroid/media/AudioRecord;

    const/4 v2, 0x7

    invoke-direct/range {v1 .. v6}, Landroid/media/AudioRecord;-><init>(IIIII)V

    sput-object v1, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;

    sget-object v1, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;

    invoke-virtual {v1}, Landroid/media/AudioRecord;->getState()I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_4

    sget-object v1, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;

    invoke-virtual {v1}, Landroid/media/AudioRecord;->startRecording()V

    new-array v1, v0, [B

    :goto_0
    sget-boolean v2, Lcom/bedoig/BTmono/MicKeeper;->isRunning:Z

    if-eqz v2, :cond_4

    sget-object v2, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;

    const/4 v3, 0x0

    invoke-virtual {v2, v1, v3, v0}, Landroid/media/AudioRecord;->read([BII)I

    move-result v2

    if-gtz v2, :cond_3

    const-wide/16 v2, 0x28

    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V

    :cond_3
    goto :goto_0
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_rec
    .catchall {:try_start_1 .. :try_end_1} :catchall_rec

    :catch_rec
    nop

    :cond_4
    :goto_cleanup
    :try_start_2
    sget-object v0, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;

    if-eqz v0, :cond_5

    sget-object v0, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;

    invoke-virtual {v0}, Landroid/media/AudioRecord;->stop()V

    sget-object v0, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;

    invoke-virtual {v0}, Landroid/media/AudioRecord;->release()V

    const/4 v0, 0x0

    sput-object v0, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_exit

    :catch_exit
    :cond_5
    return-void

    :catchall_rec
    move-exception v0

    :try_start_3
    sget-object v1, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;

    if-eqz v1, :cond_6

    sget-object v1, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;

    invoke-virtual {v1}, Landroid/media/AudioRecord;->stop()V

    sget-object v1, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;

    invoke-virtual {v1}, Landroid/media/AudioRecord;->release()V

    const/4 v1, 0x0

    sput-object v1, Lcom/bedoig/BTmono/MicKeeper;->audioRecord:Landroid/media/AudioRecord;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_finally

    :catch_finally
    :cond_6
    throw v0
.end method
