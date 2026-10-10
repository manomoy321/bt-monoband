.class public Lcom/bedoig/BTmono/Toaster;
.super Ljava/lang/Thread;
.source "Toaster.java"


# instance fields
.field private mContext:Landroid/content/Context;

.field private mLength:I

.field private mMessageId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;I)V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 15
    iput-object p2, p0, Lcom/bedoig/BTmono/Toaster;->mMessageId:Ljava/lang/String;

    .line 16
    iput-object p1, p0, Lcom/bedoig/BTmono/Toaster;->mContext:Landroid/content/Context;

    .line 17
    iput p3, p0, Lcom/bedoig/BTmono/Toaster;->mLength:I

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 27
    invoke-static {}, Landroid/os/Looper;->prepare()V

    .line 28
    iget-object v0, p0, Lcom/bedoig/BTmono/Toaster;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/bedoig/BTmono/Toaster;->mMessageId:Ljava/lang/String;

    iget v2, p0, Lcom/bedoig/BTmono/Toaster;->mLength:I

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    .line 31
    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 32
    invoke-static {}, Landroid/os/Looper;->loop()V

    return-void
.end method
