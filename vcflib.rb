require 'formula'

class RecursiveGitDownloadStrategy < GitDownloadStrategy
  def clone_args
    args = %w{clone}
    args << '--recursive'
    args << @url << @clone
  end
  def stage
    FileUtils.cp_r Dir[@clone+"{.}"], Dir.pwd
    checkout
  end
  def repo_valid?
    false
  end
  def submodules?
    false
  end
end

class Vcflib < Formula
  homepage 'https://github.com/ekg/vcflib'
  version '2014-12-12'
  url 'https://github.com/ekg/vcflib.git', :using => RecursiveGitDownloadStrategy, :revision => 'b1dfd7a7'

  def install
    ENV.deparallelize
    system 'make'
    bin.install Dir['bin/*']
  end

  test do
    system 'vcfallelicprimitives', '-h'
  end
end
