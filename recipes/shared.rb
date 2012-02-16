include_recipe "git"
include_recipe "zsh"

git "/usr/src/oh-my-zsh" do
  repository "https://github.com/robbyrussell/oh-my-zsh.git"
  reference "master"
  action :sync
end

node[:ohmyzsh][:users].each do |user|
  link "/home/#{user}/.oh-my-zsh" do
    to "/usr/src/oh-my-zsh"
    not_if "test -d /home/#{user}/.oh-my-zsh"
  end

  template "/home/#{user}/.zshrc" do
    source "zshrc.erb"
    owner user
    group user
    variables( :theme => ( node[:ohmyzsh][:theme] ))
    action :create_if_missing
  end
end
