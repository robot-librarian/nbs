#pragma once

#include "snapshot.h"
#include <contrib/ydb/services/metadata/abstract/common.h>
#include <contrib/ydb/library/accessor/accessor.h>

namespace NKikimr::NMetadata::NCSIndex {

class TFetcher: public NFetcher::TSnapshotsFetcher<TSnapshot> {
protected:
    virtual std::vector<IClassBehaviour::TPtr> DoGetManagers() const override;
public:
};

}
