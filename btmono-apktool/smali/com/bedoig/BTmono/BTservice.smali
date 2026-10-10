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

    .line 27
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    sput v0, Lcom/bedoig/BTmono/BTservice;->currentapiVersion:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    return-void
.end method

.method private createNotificationChannel()V
    .locals 4

    .line 33
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    const-string v0, "BTmono Enabled"

    const/4 v1, 0x3

    .line 37
    new-instance v2, Landroid/app/NotificationChannel;

    const-string v3, "Channel_1"

    invoke-direct {v2, v3, v0, v1}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 41
    const-class v0, Landroid/app/NotificationManager;

    invoke-virtual {p0, v0}, Lcom/bedoig/BTmono/BTservice;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    .line 42
    invoke-virtual {v0, v2}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

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

    invoke-static {p0}, Lcom/bedoig/BTmono/MicKeeper;->start(Landroid/content/Context;)V

    const/4 v0, 0x1

    .line 63
    invoke-static {v0}, Lcom/bedoig/BTmono/BTmonoVars;->setState(I)V

    const-string v1, "audio"

    .line 65
    invoke-virtual {p0, v1}, Lcom/bedoig/BTmono/BTservice;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/media/AudioManager;

    .line 67
    invoke-virtual {v1, v0}, Landroid/media/AudioManager;->setBluetoothScoOn(Z)V

    .line 68
    invoke-virtual {v1}, Landroid/media/AudioManager;->startBluetoothSco()V

    .line 71
    sget v2, Lcom/bedoig/BTmono/BTservice;->currentapiVersion:I

    const/16 v3, 0xb

    if-lt v2, v3, :cond_0

    const/4 v2, 0x3

    .line 73
    invoke-virtual {v1, v2}, Landroid/media/AudioManager;->setMode(I)V

    goto :goto_0

    :cond_0
    const/4 v2, 0x2

    .line 76
    invoke-virtual {v1, v2}, Landroid/media/AudioManager;->setMode(I)V

    .line 96
    :goto_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    iput-object v1, p0, Lcom/bedoig/BTmono/BTservice;->preferences:Landroid/content/SharedPreferences;

    .line 97
    iget-object v1, p0, Lcom/bedoig/BTmono/BTservice;->preferences:Landroid/content/SharedPreferences;

    const-string v2, "AndroidColor"

    const-string v4, "5"

    invoke-interface {v1, v2, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 101
    sget v2, Lcom/bedoig/BTmono/BTservice;->currentapiVersion:I

    if-lt v2, v3, :cond_1

    .line 103
    invoke-static {v1}, Lcom/bedoig/BTmono/BTmonoVars;->getStatusBarIdFromString(Ljava/lang/String;)I

    goto :goto_1

    .line 106
    :cond_1
    invoke-static {v1}, Lcom/bedoig/BTmono/BTmonoVars;->getIdFromString(Ljava/lang/String;)I

    .line 111
    :goto_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 130
    new-instance v1, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/bedoig/BTmono/BTservice;->getBaseContext()Landroid/content/Context;

    move-result-object v2

    const-class v3, Lcom/bedoig/BTmono/BTmono;

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 131
    invoke-virtual {p0}, Lcom/bedoig/BTmono/BTservice;->getBaseContext()Landroid/content/Context;

    move-result-object v2

    const/4 v3, 0x0

    const/high16 v4, 0x4000000

    invoke-static {v2, v3, v1, v4}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v1

    .line 133
    new-instance v2, Landroid/support/v4/app/NotificationCompat$Builder;

    const-string v4, "Channel_1"

    invoke-direct {v2, p0, v4}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    const v4, 0x7f07005c

    .line 134
    invoke-virtual {v2, v4}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    const-string v4, "BTmono"

    .line 135
    invoke-virtual {v2, v4}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    const-string v4, "BTmono is running"

    .line 136
    invoke-virtual {v2, v4}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    .line 137
    invoke-virtual {v2, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setPriority(I)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v2

    .line 138
    invoke-virtual {v2, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v1

    .line 139
    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    move-result-object v1

    .line 141
    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    .line 142
    invoke-virtual {p0, v0, v1}, Lcom/bedoig/BTmono/BTservice;->startForeground(ILandroid/app/Notification;)V

    return-void
.end method

.method public onDestroy()V
    .locals 3

    invoke-static {p0}, Lcom/bedoig/BTmono/MicKeeper;->stop(Landroid/content/Context;)V

    const/4 v0, 0x0

    .line 159
    invoke-static {v0}, Lcom/bedoig/BTmono/BTmonoVars;->setState(I)V

    const-string v1, "audio"

    .line 162
    invoke-virtual {p0, v1}, Lcom/bedoig/BTmono/BTservice;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/media/AudioManager;

    .line 165
    invoke-virtual {v1, v0}, Landroid/media/AudioManager;->setMode(I)V

    .line 168
    invoke-virtual {v1}, Landroid/media/AudioManager;->stopBluetoothSco()V

    .line 170
    invoke-virtual {v1, v0}, Landroid/media/AudioManager;->setBluetoothScoOn(Z)V

    const-string v1, "notification"

    .line 174
    invoke-virtual {p0, v1}, Lcom/bedoig/BTmono/BTservice;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/NotificationManager;

    .line 175
    invoke-virtual {v1}, Landroid/app/NotificationManager;->cancelAll()V

    .line 179
    sget v1, Lcom/bedoig/BTmono/BTservice;->currentapiVersion:I

    const/16 v2, 0x8

    if-gt v1, v2, :cond_0

    .line 182
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    iput-object v1, p0, Lcom/bedoig/BTmono/BTservice;->preferences:Landroid/content/SharedPreferences;

    .line 183
    iget-object v1, p0, Lcom/bedoig/BTmono/BTservice;->preferences:Landroid/content/SharedPreferences;

    const-string v2, "AndroidVersion"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_0

    .line 188
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v0

    .line 189
    invoke-static {v0}, Landroid/os/Process;->killProcess(I)V

    :cond_0
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 0

    const/4 p1, 0x1

    return p1
.end method
