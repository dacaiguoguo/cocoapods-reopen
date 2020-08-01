require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Reopen do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ reopen }).should.be.instance_of Command::Reopen
      end
    end
  end
end

