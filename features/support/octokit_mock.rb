class Octokit::Client
  def initialize(*args)
  end

  def commits(*args)
    []
  end

  def user(login)
    GITHUB_USERS.fetch(login) do
      raise Octokit::NotFound
    end
  end
end

GITHUB_USERS = {}

Before do
  GITHUB_USERS.clear
end
