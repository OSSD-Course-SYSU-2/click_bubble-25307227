import { GameDataManager } from '../utils/GameDataManager';
import { Level } from '../models/GameModels';

/**
 * 关卡选择页面
 */
@Entry
@Component
struct LevelSelectPage {
  @State levels: Level[] = [];
  @State currentLevel: number = 1;
  @State selectedLevel: number = 1;
  
  private gameManager: GameDataManager = GameDataManager.getInstance();
  
  aboutToAppear() {
    this.levels = this.gameManager.levels;
    this.currentLevel = this.gameManager.player.currentLevel;
    this.selectedLevel = Math.min(this.currentLevel, this.levels.length);
  }

  build() {
    Column() {
      // 标题栏
      Row() {
        Text('选择关卡')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333')
        
        Blank()
        
        Text(`当前关卡: ${this.currentLevel}`)
          .fontSize(16)
          .fontColor('#666')
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 15, bottom: 15 })
      .backgroundColor('#F5F5F5')
      
      // 关卡网格
      Grid() {
        ForEach(this.levels, (level: Level, index: number) => {
          GridItem() {
            this.LevelCard(level, index + 1)
          }
        }, (level: Level) => level.levelNumber.toString())
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
      .rowsGap(10)
      .columnsGap(10)
      .width('100%')
      .height('70%')
      .padding(15)
      
      // 底部按钮
      Row() {
        Button('返回')
          .width(100)
          .height(45)
          .backgroundColor('#999')
          .onClick(() => {
            // 返回主页
          })
        
        Blank()
        
        Button(`开始关卡 ${this.selectedLevel}`)
          .width(150)
          .height(45)
          .backgroundColor('#4ECDC4')
          .onClick(() => {
            // 开始游戏
          })
      }
      .width('100%')
      .padding({ left: 20, right: 20, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  LevelCard(level: Level, levelNum: number) {
    Column() {
      Text(`${levelNum}`)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(levelNum <= this.currentLevel ? '#4ECDC4' : '#CCC')
      
      Text(`目标: ${level.targetScore}`)
        .fontSize(12)
        .fontColor('#666')
        .margin({ top: 5 })
      
      Text(`奖励: ${level.reward}金币`)
        .fontSize(12)
        .fontColor('#FFD700')
        .margin({ top: 3 })
    }
    .width(60)
    .height(80)
    .justifyContent(FlexAlign.Center)
    .borderRadius(10)
    .backgroundColor(levelNum <= this.currentLevel ? '#E8F4F8' : '#F0F0F0')
    .border({
      width: 2,
      color: levelNum === this.selectedLevel ? '#4ECDC4' : 'transparent'
    })
    .onClick(() => {
      if (levelNum <= this.currentLevel) {
        this.selectedLevel = levelNum;
      }
    })
  }
}
