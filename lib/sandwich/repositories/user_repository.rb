# frozen_string_literal: true

class UserRepository < Hanami::Repository
  def find_by_email(email)
    users.where(email: email).map_to(User).one
  end

  def by_created_at(page: 1, per_page: 50)
    users.order(Sequel.desc(:created_at)).limit(per_page).offset(per_page * (page - 1))
  end
end
