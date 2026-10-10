.class public Lcom/bedoig/BTmono/BTservice$LocalBinder;
.super Landroid/os/Binder;
.source "BTservice.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/bedoig/BTmono/BTservice;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "LocalBinder"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/bedoig/BTmono/BTservice;


# direct methods
.method public constructor <init>(Lcom/bedoig/BTmono/BTservice;)V
    .locals 0

    .line 53
    iput-object p1, p0, Lcom/bedoig/BTmono/BTservice$LocalBinder;->this$0:Lcom/bedoig/BTmono/BTservice;

    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    return-void
.end method


# virtual methods
.method getService()Lcom/bedoig/BTmono/BTservice;
    .locals 1

    .line 55
    iget-object v0, p0, Lcom/bedoig/BTmono/BTservice$LocalBinder;->this$0:Lcom/bedoig/BTmono/BTservice;

    return-object v0
.end method
