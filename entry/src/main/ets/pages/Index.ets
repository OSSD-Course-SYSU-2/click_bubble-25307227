import { GamePage } from './GamePage';
@Entry
@Component
struct Index {
  build() {
    Column() {
      GamePage()
    }
  }
}