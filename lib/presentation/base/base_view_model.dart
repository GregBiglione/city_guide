abstract class BaseViewModel {
  // Shared variables & functions that will be used in any view model ----------

}

abstract class BaseViewModelInput {
  // Will be called while view model initialization ----------------------------
  void start();

  // Will be called while view model dies --------------------------------------
  void dispose();
}

abstract class BaseViewModelOutput {

}