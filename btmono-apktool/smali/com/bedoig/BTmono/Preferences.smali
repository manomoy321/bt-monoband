.class public Lcom/bedoig/BTmono/Preferences;
.super Landroid/preference/PreferenceActivity;
.source "Preferences.java"


# static fields
.field private static currentapiVersion:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 10
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    sput v0, Lcom/bedoig/BTmono/Preferences;->currentapiVersion:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Landroid/preference/PreferenceActivity;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 1

    .line 15
    invoke-super {p0, p1}, Landroid/preference/PreferenceActivity;->onCreate(Landroid/os/Bundle;)V

    .line 17
    sget p1, Lcom/bedoig/BTmono/Preferences;->currentapiVersion:I

    const/16 v0, 0xe

    if-lt p1, v0, :cond_0

    const p1, 0x7f0f0002

    .line 19
    invoke-virtual {p0, p1}, Lcom/bedoig/BTmono/Preferences;->addPreferencesFromResource(I)V

    goto :goto_0

    :cond_0
    const p1, 0x7f0f0001

    .line 21
    invoke-virtual {p0, p1}, Lcom/bedoig/BTmono/Preferences;->addPreferencesFromResource(I)V

    :goto_0
    return-void
.end method
