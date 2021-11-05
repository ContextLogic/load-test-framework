from coeus_model_registry_client import ModelRegistryClient, SupportedLibraries
from onnxconverter_common import data_types as onnx_data_types
import torch

# with ModelRegistryClient() as coeus:
    # # Create a namespace
    # namespace_info = coeus.create_namespace('load-test-namespace', 'platform-services')
	# # save a pytorch model
    # model_pt = train_pt()
    # model_pt.eval()  # set model to evaluation mode
    # dummy_input = torch.rand(1000, 1, 28, 28) # used to trace the model - the validity of the data is unimportant
    # args = (dummy_input,)  # model_pt(*args) must be a valid invocation
    # input_names = ["input_image"]
    # output_names = ["classified_digit"]
    # model_info, version_info = coeus.save_model('load-test-namespace', 'my-model-pt', 'v1', SupportedLibraries.PYTORCH_1,
    #                                             model_pt, args, input_names, output_names)
coeus = ModelRegistryClient()
models = coeus.get_models('load-test-namespace')
print(models)
