.class Lcom/bedoig/BTmono/BTmono$2;
.super Ljava/lang/Object;
.source "BTmono.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/bedoig/BTmono/BTmono;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/bedoig/BTmono/BTmono;


# direct methods
.method constructor <init>(Lcom/bedoig/BTmono/BTmono;)V
    .locals 0

    .line 331
    iput-object p1, p0, Lcom/bedoig/BTmono/BTmono$2;->this$0:Lcom/bedoig/BTmono/BTmono;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .line 334
    new-instance p1, Landroid/content/Intent;

    const-string v0, "android.intent.action.VIEW"

    invoke-direct {p1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v0, "market://details?id=com.bedoig.BTmono_Donate"

    .line 335
    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 336
    iget-object v0, p0, Lcom/bedoig/BTmono/BTmono$2;->this$0:Lcom/bedoig/BTmono/BTmono;

    invoke-virtual {v0, p1}, Lcom/bedoig/BTmono/BTmono;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
