class Note < ApplicationRecord

  belongs_to :user

  after_update_commit {NoteBroadcastJob.perform_now self}

end
