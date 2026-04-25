import { GameDataManager } from '../utils/GameDataManager';
import { Item, Equipment } from '../models/GameModels';
import router from '@ohos.router';

/**
 * 商店页面
 */
@Entry
@Component
struct ShopPage {
  @State currentTab: number = 0; // 0: 道具, 1: 装备
  @State items: Item[] = [];
  @State equipments: Equipment[] = [];
  @State coins: number = 0;
  @State showToast: boolean = false;
  @State toastMessage: string = '';

  private gameManager: GameDataManager = GameDataManager.getInstance();

  aboutToAppear() {
    this.items = this.gameManager.items;
    this.equipments = this.gameManager.equipments;
    this.coins = this.gameManager.player.coins;
  }

  /**
   * 显示提示
   */
  showTip(message: string): void {
    this.toastMessage = message;
    this.showToast = true;
    setTimeout(() => {
      this.showToast = false;
    }, 2000);
  }

  /**
   * 购买道具
   */
  buyItem(itemId: number): void {
    const item = this.items.find(i => i.id === itemId);
    if (item) {
      if (this.gameManager.buyItem(itemId)) {
        this.coins = this.gameManager.player.coins;
        this.showTip(`成功购买 ${item.name}！`);
      } else {
        this.showTip('金币不足！');
      }
    }
  }

  /**
   * 升级装备
   */
  upgradeEquip(equipId: number): void {
    if (this.gameManager.upgradeEquipment(equipId)) {
      this.coins = this.gameManager.player.coins;
      // 更新装备列表显示
      this.equipments = this.gameManager.equipments;
      this.showTip('升级成功！');
    } else {
      this.showTip('金币不足或已达最高等级！');
    }
  }

  build() {
    Stack() {
      Column() {
        // 标题栏
        Row() {
          Text('商店')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333')
          
          Blank()
          
          Row() {
            Text('💰')
              .fontSize(20)
            Text(`${this.coins}`)
              .fontSize(18)
              .fontColor('#FFD700')
              .fontWeight(FontWeight.Bold)
              .margin({ left: 5 })
          }
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 15, bottom: 15 })
        .backgroundColor('#F5F5F5')
        
        // 标签切换
        Row() {
          Text('道具')
            .fontSize(18)
            .fontColor(this.currentTab === 0 ? '#4ECDC4' : '#666')
            .fontWeight(this.currentTab === 0 ? FontWeight.Bold : FontWeight.Normal)
            .padding(10)
            .onClick(() => {
              this.currentTab = 0;
            })
          
          Blank()
          
          Text('装备')
            .fontSize(18)
            .fontColor(this.currentTab === 1 ? '#4ECDC4' : '#666')
            .fontWeight(this.currentTab === 1 ? FontWeight.Bold : FontWeight.Normal)
            .padding(10)
            .onClick(() => {
              this.currentTab = 1;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 10, bottom: 10 })
        .backgroundColor('#FFF')
        
        // 内容区域
        if (this.currentTab === 0) {
          this.ItemList()
        } else {
          this.EquipmentList()
        }
        
        // 返回按钮
        Button('返回')
          .width(100)
          .height(45)
          .backgroundColor('#999')
          .margin({ top: 20, bottom: 20 })
          .onClick(() => {
            router.back();
          })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
      
      // Toast提示
      if (this.showToast) {
        Text(this.toastMessage)
          .fontSize(16)
          .fontColor(Color.White)
          .padding(15)
          .backgroundColor('#80000000')
          .borderRadius(10)
          .position({ x: '50%', y: '50%' })
          .translate({ x: '-50%', y: '-50%' })
          .zIndex(999)
      }
    }
  }

  @Builder
  ItemList() {
    List() {
      ForEach(this.items, (item: Item) => {
        ListItem() {
          Row() {
            // 道具图标
            Column() {
              Text(this.getItemIcon(item.effect))
                .fontSize(40)
            }
            .width(60)
            .height(60)
            .justifyContent(FlexAlign.Center)
            .backgroundColor('#E8F4F8')
            .borderRadius(10)
            
            // 道具信息
            Column() {
              Text(item.name)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333')
              
              Text(item.description)
                .fontSize(14)
                .fontColor('#666')
                .margin({ top: 5 })
              
              Row() {
                Text(`💰 ${item.price}`)
                  .fontSize(16)
                  .fontColor('#FFD700')
                
                Blank()
                
                Text(`拥有: ${this.gameManager.player.items.get(item.id) || 0}`)
                  .fontSize(14)
                  .fontColor('#999')
              }
              .width('100%')
              .margin({ top: 5 })
            }
            .layoutWeight(1)
            .padding({ left: 15 })
            .alignItems(HorizontalAlign.Start)
            
            // 购买按钮
            Button('购买')
              .width(70)
              .height(40)
              .fontSize(14)
              .backgroundColor('#4ECDC4')
              .onClick(() => {
                this.buyItem(item.id);
              })
          }
          .width('100%')
          .padding(15)
          .backgroundColor('#FFF')
          .borderRadius(10)
          .shadow({
            radius: 5,
            color: '#10000000',
            offsetX: 0,
            offsetY: 2
          })
          .margin({ bottom: 10 })
        }
      }, (item: Item) => item.id.toString())
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ left: 15, right: 15, top: 10 })
  }

  @Builder
  EquipmentList() {
    List() {
      ForEach(this.equipments, (equip: Equipment) => {
        ListItem() {
          Row() {
            // 装备图标
            Column() {
              Text(this.getEquipIcon(equip.id))
                .fontSize(40)
            }
            .width(60)
            .height(60)
            .justifyContent(FlexAlign.Center)
            .backgroundColor('#FFE4E1')
            .borderRadius(10)
            
            // 装备信息
            Column() {
              Text(equip.name)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333')
              
              Text(equip.description)
                .fontSize(14)
                .fontColor('#666')
                .margin({ top: 5 })
              
              Row() {
                Text(`等级: ${equip.currentLevel}/${equip.maxLevel}`)
                  .fontSize(14)
                  .fontColor('#4ECDC4')
                
                Blank()
                
                Text(`效果: +${Math.round((equip.getEffect() - 1) * 100)}%`)
                  .fontSize(14)
                  .fontColor('#FF6B6B')
              }
              .width('100%')
              .margin({ top: 5 })
            }
            .layoutWeight(1)
            .padding({ left: 15 })
            .alignItems(HorizontalAlign.Start)
            
            // 升级按钮
            Column() {
              if (equip.currentLevel < equip.maxLevel) {
                Button(`升级`)
                  .width(70)
                  .height(35)
                  .fontSize(12)
                  .backgroundColor('#FF6B6B')
                  .onClick(() => {
                    this.upgradeEquip(equip.id);
                  })
                
                Text(`💰${equip.getUpgradePrice()}`)
                  .fontSize(12)
                  .fontColor('#FFD700')
                  .margin({ top: 3 })
              } else {
                Text('已满级')
                  .fontSize(14)
                  .fontColor('#999')
              }
            }
            .width(80)
          }
          .width('100%')
          .padding(15)
          .backgroundColor('#FFF')
          .borderRadius(10)
          .shadow({
            radius: 5,
            color: '#10000000',
            offsetX: 0,
            offsetY: 2
          })
          .margin({ bottom: 10 })
        }
      }, (equip: Equipment) => equip.id.toString())
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ left: 15, right: 15, top: 10 })
  }

  /**
   * 获取道具图标
   */
  getItemIcon(effect: string): string {
    const icons: Record<string, string> = {
      'double_score': '⚡',
      'time_extend': '⏰',
      'magnet': '🧲',
      'bomb': '💣',
      'shield': '🛡️',
      // 新增道具图标
      'triple_score': '🌟',
      'super_time_extend': '⏱️',
      'super_magnet': '🧲',
      'freeze': '❄️',
      'lucky_star': '🍀'
    };
    return icons[effect] || '🎁';
  }

  /**
   * 获取装备图标
   */
  getEquipIcon(id: number): string {
    const icons: Record<number, string> = {
      1: '📊',
      2: '💰',
      3: '🔍',
      4: '⏱️',
      5: '🔥',
      // 新增装备图标
      6: '🐢',
      7: '💥',
      8: '🍀',
      9: '⏰',
      10: '⚡'
    };
    return icons[id] || '⚙️';
  }
}
