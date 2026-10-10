.class public Lcom/bedoig/BTmono/BTmono;
.super Landroid/app/Activity;
.source "BTmono.java"


# static fields
.field private static final REQUEST_ENABLE_BT:I


# instance fields
.field private PremiumClickListener:Landroid/view/View$OnClickListener;

.field private VolumeChange:Landroid/widget/SeekBar$OnSeekBarChangeListener;

.field private am:Landroid/media/AudioManager;

.field private bg:Landroid/widget/ImageView;

.field preferences:Landroid/content/SharedPreferences;

.field private seekbar:Landroid/widget/SeekBar;

.field state:I

.field volume:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 40
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 253
    new-instance v0, Lcom/bedoig/BTmono/BTmono$1;

    invoke-direct {v0, p0}, Lcom/bedoig/BTmono/BTmono$1;-><init>(Lcom/bedoig/BTmono/BTmono;)V

    iput-object v0, p0, Lcom/bedoig/BTmono/BTmono;->VolumeChange:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    .line 331
    new-instance v0, Lcom/bedoig/BTmono/BTmono$2;

    invoke-direct {v0, p0}, Lcom/bedoig/BTmono/BTmono$2;-><init>(Lcom/bedoig/BTmono/BTmono;)V

    iput-object v0, p0, Lcom/bedoig/BTmono/BTmono;->PremiumClickListener:Landroid/view/View$OnClickListener;

    return-void
.end method

.method static synthetic access$000(Lcom/bedoig/BTmono/BTmono;)Landroid/widget/SeekBar;
    .locals 0

    .line 40
    iget-object p0, p0, Lcom/bedoig/BTmono/BTmono;->seekbar:Landroid/widget/SeekBar;

    return-object p0
.end method

.method static synthetic access$100(Lcom/bedoig/BTmono/BTmono;)Landroid/media/AudioManager;
    .locals 0

    .line 40
    iget-object p0, p0, Lcom/bedoig/BTmono/BTmono;->am:Landroid/media/AudioManager;

    return-object p0
.end method

.method private getVersion()I
    .locals 3

    .line 45
    :try_start_0
    invoke-virtual {p0}, Lcom/bedoig/BTmono/BTmono;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/bedoig/BTmono/BTmono;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x80

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    .line 46
    iget v0, v0, Landroid/content/pm/PackageInfo;->versionCode:I
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 48
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Name not found"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 v0, 0x0

    :goto_0
    return v0
.end method


# virtual methods
.method public Off()V
    .locals 2

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/bedoig/BTmono/BTmonoVars;->setState(I)V

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/bedoig/BTmono/BTservice;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/bedoig/BTmono/BTmono;->stopService(Landroid/content/Intent;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    invoke-virtual {p0}, Lcom/bedoig/BTmono/BTmono;->updateImages()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public On()V
    .locals 3

    const/4 v0, 0x1

    invoke-static {v0}, Lcom/bedoig/BTmono/BTmonoVars;->setState(I)V

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/bedoig/BTmono/BTservice;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_0

    invoke-virtual {p0, v0}, Lcom/bedoig/BTmono/BTmono;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    goto :goto_0

    :cond_0
    invoke-virtual {p0, v0}, Lcom/bedoig/BTmono/BTmono;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    :try_start_1
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/bedoig/BTmono/BTservice;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/bedoig/BTmono/BTmono;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :goto_0
    :try_start_2
    invoke-virtual {p0}, Lcom/bedoig/BTmono/BTmono;->updateImages()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    return-void
.end method

.method public ViewBToff(Landroid/view/View;)V
    .locals 0

    :try_start_0
    invoke-virtual {p0}, Lcom/bedoig/BTmono/BTmono;->Off()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public ViewBTon(Landroid/view/View;)V
    .locals 0

    :try_start_0
    invoke-virtual {p0}, Lcom/bedoig/BTmono/BTmono;->On()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 3

    .line 77
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0a001b

    .line 78
    invoke-virtual {p0, p1}, Lcom/bedoig/BTmono/BTmono;->setContentView(I)V

    invoke-direct {p0}, Lcom/bedoig/BTmono/BTmono;->requestRequiredPermissions()V

    .line 82
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object p1

    const-string v0, "versionNo"

    const/4 v1, 0x0

    .line 83
    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    .line 84
    invoke-direct {p0}, Lcom/bedoig/BTmono/BTmono;->getVersion()I

    move-result v2

    if-ge v0, v2, :cond_0

    .line 87
    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "versionNo"

    .line 88
    invoke-interface {p1, v0, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 89
    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 91
    new-instance p1, Landroid/app/AlertDialog$Builder;

    invoke-direct {p1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v0, "What\'s new"

    .line 93
    invoke-virtual {p1, v0}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    const-string v0, "v1.3.3\n\n-Support newer versions of Android. Minor bug fixes.\n\n1.3.1\n\n-Minor Update - add link to device bluetooth settings under menu options."

    .line 95
    invoke-virtual {p1, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    const-string v0, "cool"

    const/4 v2, 0x0

    .line 98
    invoke-virtual {p1, v0, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 100
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    :cond_0
    invoke-virtual {p0}, Lcom/bedoig/BTmono/BTmono;->updateImages()V

    const p1, 0x7f080065

    .line 132
    invoke-virtual {p0, p1}, Lcom/bedoig/BTmono/BTmono;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/SeekBar;

    iput-object p1, p0, Lcom/bedoig/BTmono/BTmono;->seekbar:Landroid/widget/SeekBar;

    const-string p1, "audio"

    .line 133
    invoke-virtual {p0, p1}, Lcom/bedoig/BTmono/BTmono;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/media/AudioManager;

    iput-object p1, p0, Lcom/bedoig/BTmono/BTmono;->am:Landroid/media/AudioManager;

    .line 136
    iget-object p1, p0, Lcom/bedoig/BTmono/BTmono;->am:Landroid/media/AudioManager;

    const/4 v0, 0x3

    invoke-virtual {p1, v0}, Landroid/media/AudioManager;->getStreamVolume(I)I

    move-result p1

    iput p1, p0, Lcom/bedoig/BTmono/BTmono;->volume:I

    .line 139
    iget-object p1, p0, Lcom/bedoig/BTmono/BTmono;->seekbar:Landroid/widget/SeekBar;

    iget-object v2, p0, Lcom/bedoig/BTmono/BTmono;->am:Landroid/media/AudioManager;

    invoke-virtual {v2, v0}, Landroid/media/AudioManager;->getStreamMaxVolume(I)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/widget/SeekBar;->setMax(I)V

    .line 143
    iget-object p1, p0, Lcom/bedoig/BTmono/BTmono;->seekbar:Landroid/widget/SeekBar;

    iget v0, p0, Lcom/bedoig/BTmono/BTmono;->volume:I

    invoke-virtual {p1, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 144
    iget-object p1, p0, Lcom/bedoig/BTmono/BTmono;->seekbar:Landroid/widget/SeekBar;

    iget-object v0, p0, Lcom/bedoig/BTmono/BTmono;->VolumeChange:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {p1, v0}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    const p1, 0x7f080006

    .line 156
    invoke-virtual {p0, p1}, Lcom/bedoig/BTmono/BTmono;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    const-string v0, "Full Version Unlocked"

    .line 157
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 158
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 166
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object p1

    .line 167
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result p1

    if-nez p1, :cond_1

    .line 168
    new-instance p1, Landroid/content/Intent;

    const-string v0, "android.bluetooth.adapter.action.REQUEST_ENABLE"

    invoke-direct {p1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 169
    invoke-virtual {p0, p1, v1}, Lcom/bedoig/BTmono/BTmono;->startActivityForResult(Landroid/content/Intent;I)V

    :cond_1
    return-void
.end method

.method public onCreateOptionsMenu(Landroid/view/Menu;)Z
    .locals 2

    .line 224
    invoke-virtual {p0}, Lcom/bedoig/BTmono/BTmono;->getMenuInflater()Landroid/view/MenuInflater;

    move-result-object v0

    const/high16 v1, 0x7f0b0000

    .line 225
    invoke-virtual {v0, v1, p1}, Landroid/view/MenuInflater;->inflate(ILandroid/view/Menu;)V

    const/4 p1, 0x1

    return p1
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .locals 1

    .line 233
    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result p1

    packed-switch p1, :pswitch_data_0

    goto :goto_0

    .line 237
    :pswitch_0
    new-instance p1, Landroid/content/Intent;

    const-class v0, Lcom/bedoig/BTmono/Preferences;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 238
    invoke-virtual {p0, p1}, Lcom/bedoig/BTmono/BTmono;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    .line 243
    :pswitch_1
    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    const-string v0, "android.settings.BLUETOOTH_SETTINGS"

    .line 244
    invoke-virtual {p1, v0}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 245
    invoke-virtual {p0, p1}, Lcom/bedoig/BTmono/BTmono;->startActivity(Landroid/content/Intent;)V

    :goto_0
    const/4 p1, 0x1

    return p1

    :pswitch_data_0
    .packed-switch 0x7f080041
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onRestart()V
    .locals 0

    .line 208
    invoke-super {p0}, Landroid/app/Activity;->onRestart()V

    .line 210
    invoke-virtual {p0}, Lcom/bedoig/BTmono/BTmono;->updateImages()V

    return-void
.end method

.method public onResume()V
    .locals 0

    .line 216
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 218
    invoke-virtual {p0}, Lcom/bedoig/BTmono/BTmono;->updateImages()V

    return-void
.end method

.method public onStart()V
    .locals 3

    .line 188
    invoke-super {p0}, Landroid/app/Activity;->onStart()V

    .line 192
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/bedoig/BTmono/BTmono;->preferences:Landroid/content/SharedPreferences;

    .line 193
    iget-object v0, p0, Lcom/bedoig/BTmono/BTmono;->preferences:Landroid/content/SharedPreferences;

    const-string v1, "autoOn"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 198
    invoke-virtual {p0}, Lcom/bedoig/BTmono/BTmono;->On()V

    .line 201
    :cond_0
    invoke-virtual {p0}, Lcom/bedoig/BTmono/BTmono;->updateImages()V

    return-void
.end method

.method public updateImages()V
    .locals 3

    const v0, 0x7f08003e

    .line 317
    invoke-virtual {p0, v0}, Lcom/bedoig/BTmono/BTmono;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/bedoig/BTmono/BTmono;->bg:Landroid/widget/ImageView;

    .line 318
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/bedoig/BTmono/BTmono;->preferences:Landroid/content/SharedPreferences;

    .line 319
    iget-object v0, p0, Lcom/bedoig/BTmono/BTmono;->preferences:Landroid/content/SharedPreferences;

    const-string v1, "AndroidColor"

    const-string v2, "5"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 322
    invoke-static {v0}, Lcom/bedoig/BTmono/BTmonoVars;->getIdFromString(Ljava/lang/String;)I

    move-result v0

    .line 323
    iget-object v1, p0, Lcom/bedoig/BTmono/BTmono;->bg:Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    return-void
.end method

.method private requestRequiredPermissions()V
    .locals 5

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_skip

    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "android.permission.RECORD_AUDIO"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "android.permission.BLUETOOTH_CONNECT"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "android.permission.POST_NOTIFICATIONS"

    aput-object v2, v0, v1

    const/16 v1, 0x3e9

    invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->requestPermissions([Ljava/lang/String;I)V

    :cond_skip
    return-void
.end method

