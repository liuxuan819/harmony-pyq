import { TweetsItem } from '../viewModel/TweetsListViewModel'

@Component
export struct TweetsListItems {
  @ObjectLink tweets: TweetsItem;

  getGridTemplate(): string {
    if (this.tweets.images.length === 1) {
      return '120';
    } else if (this.tweets.images.length === 4) {
      return '90 90';
    } else {
      return '90 90 90'
    }
  }

  @Builder
  renderImages() {
    Grid() {
      ForEach(this.tweets.images, (image) => {
        GridItem() {
          Image(image.url)
            .alt( $r("app.media.defaultImage"))
            .width(this.tweets.images.length === 1 ? 120 : 90)
            .height(this.tweets.images.length === 1 ? 120 : 90)
        }
      })
    }
    .columnsTemplate(this.getGridTemplate())
    .rowsTemplate(this.getGridTemplate())
    .columnsGap(5)
    .rowsGap(5)
    .width(this.tweets.images.length === 4 ? 185 : 280)
    .margin({ top: 10 })
  }

  @Builder
  renderComments() {
    Column() {
      ForEach(this.tweets.comments, comment => {
        Text() {
          Span(comment.sender.nick)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Blue)
            .fontSize(14)
          Span(': ' + comment.content)
            .fontColor(Color.Black)
            .fontSize(14)
        }
      })
    }
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#EEE')
    .width('100%')
    .borderRadius(3)
    .padding(5)
    .margin({ top: 10 })
  }

  build() {
    Column() {
      Flex() {
        Image(this.tweets.sender.avatar)
          .alt($r("app.media.defaultAvatar"))
          .width(40)
          .height(40)
          .borderRadius(8)
          .margin({
            left: 20,
            right: 10,
          })
          .flexShrink(0)
        Column() {
          Text(this.tweets.sender.nick)
            .fontColor(Color.Blue)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 5 })
          if (this.tweets.content) {
            Text(this.tweets.content)
              .fontSize(16)
              .fontColor(Color.Black)
              .margin({ top: 5 })
          }
          if (this.tweets.images) {
            this.renderImages()
          }
          if (this.tweets.comments) {
            this.renderComments()
          }
        }
        .width('75%')
        .alignItems(HorizontalAlign.Start)
        .margin({ right: 25 })
      }
      Divider()
        .margin({
          top: 15,
          bottom: 15,
        })
    }
    .width('100%')
  }
}