#
# Cookbook Name:: oh-my-zsh
# Recipe:: default
#
# Copyright 2011, Heavy Water Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "git"
include_recipe "zsh"

node[:ohmyzsh][:users].each do |user|
  git "/home/#{user}/.oh-my-zsh" do
    repository "https://github.com/robbyrussell/oh-my-zsh.git"
    reference "master"
    user user
    group user
    action :checkout
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
