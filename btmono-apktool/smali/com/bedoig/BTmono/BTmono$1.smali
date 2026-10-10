.class Lcom/bedoig/BTmono/BTmono$1;
.super Ljava/lang/Object;
.source "BTmono.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


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

    .line 253
    iput-object p1, p0, Lcom/bedoig/BTmono/BTmono$1;->this$0:Lcom/bedoig/BTmono/BTmono;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 1

    .line 263
    iget-object p1, p0, Lcom/bedoig/BTmono/BTmono$1;->this$0:Lcom/bedoig/BTmono/BTmono;

    invoke-static {p1}, Lcom/bedoig/BTmono/BTmono;->access$000(Lcom/bedoig/BTmono/BTmono;)Landroid/widget/SeekBar;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/SeekBar;->getProgress()I

    move-result p1

    .line 265
    iget-object p2, p0, Lcom/bedoig/BTmono/BTmono$1;->this$0:Lcom/bedoig/BTmono/BTmono;

    invoke-static {p2}, Lcom/bedoig/BTmono/BTmono;->access$100(Lcom/bedoig/BTmono/BTmono;)Landroid/media/AudioManager;

    move-result-object p2

    const/4 p3, 0x3

    const/4 v0, 0x1

    invoke-virtual {p2, p3, p1, v0}, Landroid/media/AudioManager;->setStreamVolume(III)V

    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    return-void
.end method
