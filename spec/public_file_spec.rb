require 'spec_helper'

describe PublicFile do
  before(:each) do
    @sinatra_app = mock('Sinatra', :send_file => true)
  end
  it "creates a new instance and sends" do
    path = 'folder/index.html'
    public_file = PublicFile.new(@sinatra_app, path)
    PublicFile.should_receive(:new).with(@sinatra_app, path).and_return(public_file)
    public_file.should_receive(:push).and_return('something')

    PublicFile.push(@sinatra_app, path)
  end

  describe "initialisation" do
    it "should raise an ArgumentError without a path" do
      lambda { PublicFile.new(@sinatra_app) }.should raise_error(ArgumentError)
    end

    it "should set pathname with an argument" do
      path = 'folder/index.html'
      public_file = PublicFile.new(@sinatra_app, path)
      public_file.pathname.should == Pathname.new(path)
    end
  end

  describe "rewrite_path" do
    it "appends index.html when there is no extension" do
      public_file = PublicFile.new(@sinatra_app, '/parent/child')
      public_file.path.should == '/parent/child/index.html'
    end

    it "rewrites an htm extension to html" do
      public_file = PublicFile.new(@sinatra_app, '/parent/child/file.htm')
      public_file.path.should == '/parent/child/file.html'
    end

    it "preserves existing extensions" do
      public_file = PublicFile.new(@sinatra_app, '/parent/child/file.extension')
      public_file.path.should == '/parent/child/file.extension'
    end
  end
end
