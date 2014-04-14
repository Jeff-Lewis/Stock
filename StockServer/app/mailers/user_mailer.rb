# This Class is used for sending email
class UserMailer < ActionMailer::Base
  default from: "stock.earning.cal@gmail.com"

  # This method is used to send welcome email to users
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Stock Earning Calendar')
  end

  # This method is used to send bid confirm email to users
  # telling you what you have bid is successful
  def bid_confirm_email(bid)
    @bid_confirm = bid
    @user_buyer = @bid_confirm.user
    mail(to: @user_buyer.email, subject: 'Bid Confirmation')
  end

  # This method is used to send the item seller email when there is new bid on his item.
  def seller_bid_notification(bid)
    @bid_notice = bid
    @seller = @bid_notice.post.user
    mail(to: @seller.email, subject: 'Bid Notification')
  end

  # This method is used to send email to users, if the item the users watch has changed
  def watch_item_notification(item)
    @watch_post_item = item
    @post = Post.find(@watch_post_item.post_id)
    @seller = WatchList.find(@watch_post_item.watch_list_id).user
    mail(to: @seller.email, subject: 'Watch Item Notification')
  end

  # This method is used to send email to the item winner
  # telling him that he has win the item and he should give his feedback
  def feedback_notification(post)
    @post = post
    @bids = Bid.where(:price => @post.max_bid).where(:post_id => @post.id)
    @bids.each do |bid|
      @seller = bid.user
    end
    mail(to: @seller.email, subject: 'Feed Back Notification')
  end

end
