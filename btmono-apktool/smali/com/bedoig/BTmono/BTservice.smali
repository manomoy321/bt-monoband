.class public Lcom/bedoig/BTmono/BTservice;
.super Landroid/app/Service;
.source "BTservice.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/bedoig/BTmono/BTservice$LocalBinder;
    }
.end annotation


# static fields
.field private static final BTmono_ID:I = 0x1

.field private static final CHANNEL_ID:Ljava/lang/String; = "Channel_1"

.field private static currentapiVersion:I


# instance fields
.field preferences:Landroid/content/SharedPreferences;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    sput v0, Lcom/bedoig/BTmono/BTservice;->currentapiVersion:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    return-void
.end method

.method private createNotificationChannel()V
    .locals 4

    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    const-string v0, "BTmono Enabled"

    const/4 v1, 0x3

    new-instance v2, Landroid/app/NotificationChannel;

    const-string v3, "Channel_1"

    invoke-direct {v2, v3, v0, v1}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    const-string v0, "notification"

    invoke-virtual {p0, v0}, Lcom/bedoig/BTmono/BTservice;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    if-eqz v0, :cond_0

    invoke-virtual {v0, v2}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()V
    .locals 5

    invoke-direct {p0}, Lcom/bedoig/BTmono/BTservice;->createNotificationChannel()V

    :try_start_fg
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/bedoig/BTmono/BTmono;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/4 v1, 0x0

    const/high16 v2, 0xc000000

    invoke-static {p0, v1, v0, v2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    new-instance v1, Landroid/support/v4/app/NotificationCompat$Builder;

    const-string v2, "Channel_1"

    invoke-direct {v1, p0, v2}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    const v2, 0x7f07005c

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v1

    const-string v2, "BT-Mono"

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v1

    const-string v2, "BT-Mono is active"

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setPriority(I)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {p0, v1, v0}, Lcom/bedoig/BTmono/BTservice;->startForeground(ILandroid/app/Notification;)V
    :try_end_fg
    .catch Ljava/lang/Throwable; {:try_start_fg .. :try_end_fg} :catch_fg

    :catch_fg
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/bedoig/BTmono/BTmonoVars;->setState(I)V

    :try_start_audio
    const-string v0, "audio"

    invoke-virtual {p0, v0}, Lcom/bedoig/BTmono/BTservice;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/AudioManager;

    if-eqz v0, :cond_audio_done

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/media/AudioManager;->setBluetoothScoOn(Z)V

    invoke-virtual {v0}, Landroid/media/AudioManager;->startBluetoothSco()V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/media/AudioManager;->setMode(I)V
    :cond_audio_done
    :try_end_audio
    .catch Ljava/lang/Throwable; {:try_start_audio .. :try_end_audio} :catch_audio

    :catch_audio
    :try_start_mic
    invoke-static {p0}, Lcom/bedoig/BTmono/MicKeeper;->start(Landroid/content/Context;)V
    :try_end_mic
    .catch Ljava/lang/Throwable; {:try_start_mic .. :try_end_mic} :catch_mic

    :catch_mic
    return-void
.end method

.method public onDestroy()V
    .locals 2

    :try_start_0
    invoke-static {p0}, Lcom/bedoig/BTmono/MicKeeper;->stop(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/bedoig/BTmono/BTmonoVars;->setState(I)V

    :try_start_1
    const-string v1, "audio"

    invoke-virtual {p0, v1}, Lcom/bedoig/BTmono/BTservice;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/media/AudioManager;

    if-eqz v1, :cond_audio_off

    invoke-virtual {v1, v0}, Landroid/media/AudioManager;->setMode(I)V

    invoke-virtual {v1}, Landroid/media/AudioManager;->stopBluetoothSco()V

    invoke-virtual {v1, v0}, Landroid/media/AudioManager;->setBluetoothScoOn(Z)V
    :cond_audio_off
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/bedoig/BTmono/BTservice;->stopForeground(Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :try_start_3
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Lcom/bedoig/BTmono/BTservice;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    if-eqz v0, :cond_notif_off

    invoke-virtual {v0}, Landroid/app/NotificationManager;->cancelAll()V
    :cond_notif_off
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 0

    const/4 p1, 0x1

    return p1
.end method
