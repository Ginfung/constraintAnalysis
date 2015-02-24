% function []= SXFMParaser()
% %load the repositories.
% %%Set up the parameters
% LoadRepoCount = 10;
%     %%get the XML file according to the RepositoryURL
%     urls = textread('RepositoryURL.txt','%s');
%     for i = 1:LoadRepoCount
%         model  = xmlread(urls{i,1});
%         e = loadSxfmModel(model);
%         e.constraints
%     end
% end
% 
% 
% function data = loadSxfmModel(model)
%      fea = model.getElementsByTagName('feature_tree');
%      feature = fea.item(0).getTextContent;
%      con = model.getElementsByTagName('constraints');
%      constraints = con.item(0).getTextContent;
%      data.feature = feature;
%      data.constraints = constraints;
%  end

clear all
javaaddpath('sxfm.jar');
javaaddpath('t11.jar');
import constraints.PropositionalFormula;
import fm.FeatureGroup;
import fm.FeatureModel;
import fm.FeatureModelStatistics;
import fm.FeatureTreeNode;
import fm.RootNode;
import fm.SolitaireFeature;
import fm.XMLFeatureModel;
import pap.XMLFeatureModelParserSample;
urls = textread('RepositoryURL.txt','%s');
featureModel = fm.XMLFeatureModel(urls{1,1},10); %XMLFeatureModel.USE_VARIABLE_NAME_AS_ID = 10
featureModel.loadModel();
m = featureModel.getRoot();  


