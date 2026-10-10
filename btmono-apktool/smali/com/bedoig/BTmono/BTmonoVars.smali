.class public Lcom/bedoig/BTmono/BTmonoVars;
.super Landroid/app/Application;
.source "BTmonoVars.java"


# static fields
.field private static myState:I


# instance fields
.field bg:Landroid/widget/ImageView;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method

.method public static getIdFromString(Ljava/lang/String;)I
    .locals 2

    .line 39
    invoke-static {}, Lcom/bedoig/BTmono/BTmonoVars;->getState()I

    move-result v0

    if-nez v0, :cond_0

    const p0, 0x7f07005e

    goto/16 :goto_0

    :cond_0
    const/4 v1, 0x1

    if-ne v0, v1, :cond_9

    const-string v0, "1"

    .line 46
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const p0, 0x7f070054

    goto :goto_0

    :cond_1
    const-string v0, "2"

    .line 51
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const p0, 0x7f070056

    goto :goto_0

    :cond_2
    const-string v0, "3"

    .line 56
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    const p0, 0x7f070058

    goto :goto_0

    :cond_3
    const-string v0, "4"

    .line 61
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    const p0, 0x7f07005a

    goto :goto_0

    :cond_4
    const-string v0, "5"

    .line 66
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    const p0, 0x7f07005c

    goto :goto_0

    :cond_5
    const-string v0, "6"

    .line 71
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    const p0, 0x7f07005f

    goto :goto_0

    :cond_6
    const-string v0, "7"

    .line 76
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    const p0, 0x7f070061

    goto :goto_0

    :cond_7
    const-string v0, "8"

    .line 81
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    const p0, 0x7f070063

    goto :goto_0

    :cond_8
    const-string v0, "9"

    .line 86
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_9

    const p0, 0x7f070065

    goto :goto_0

    :cond_9
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method public static getState()I
    .locals 1

    .line 19
    sget v0, Lcom/bedoig/BTmono/BTmonoVars;->myState:I

    return v0
.end method

.method public static getStatusBarIdFromString(Ljava/lang/String;)I
    .locals 2

    .line 102
    invoke-static {}, Lcom/bedoig/BTmono/BTmonoVars;->getState()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_8

    const-string v0, "1"

    .line 109
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const p0, 0x7f070055

    goto :goto_0

    :cond_0
    const-string v0, "2"

    .line 114
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const p0, 0x7f070057

    goto :goto_0

    :cond_1
    const-string v0, "3"

    .line 119
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const p0, 0x7f070059

    goto :goto_0

    :cond_2
    const-string v0, "4"

    .line 124
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    const p0, 0x7f07005b

    goto :goto_0

    :cond_3
    const-string v0, "5"

    .line 129
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    const p0, 0x7f07005d

    goto :goto_0

    :cond_4
    const-string v0, "6"

    .line 134
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    const p0, 0x7f070060

    goto :goto_0

    :cond_5
    const-string v0, "7"

    .line 139
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    const p0, 0x7f070062

    goto :goto_0

    :cond_6
    const-string v0, "8"

    .line 144
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    const p0, 0x7f070064

    goto :goto_0

    :cond_7
    const-string v0, "9"

    .line 149
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_8

    const p0, 0x7f070066

    goto :goto_0

    :cond_8
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method public static setState(I)V
    .locals 0

    .line 22
    sput p0, Lcom/bedoig/BTmono/BTmonoVars;->myState:I

    return-void
.end method
