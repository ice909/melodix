/**
 * MelodixAPI
 * Melodix API
 *
 * The version of the OpenAPI document: 1.0.0
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */

/*
 * MDGetMvDetail_200_response_data_videoGroup_inner.h
 *
 * 
 */

#ifndef MDGetMvDetail_200_response_data_videoGroup_inner_H
#define MDGetMvDetail_200_response_data_videoGroup_inner_H

#include <QJsonObject>

#include <QString>

#include "MDEnum.h"
#include "MDObject.h"

namespace MelodixAPI {

class MDGetMvDetail_200_response_data_videoGroup_inner : public MDObject {
public:
    MDGetMvDetail_200_response_data_videoGroup_inner();
    MDGetMvDetail_200_response_data_videoGroup_inner(QString json);
    ~MDGetMvDetail_200_response_data_videoGroup_inner() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    qint32 getId() const;
    void setId(const qint32 &id);
    bool is_id_Set() const;
    bool is_id_Valid() const;

    QString getName() const;
    void setName(const QString &name);
    bool is_name_Set() const;
    bool is_name_Valid() const;

    qint32 getType() const;
    void setType(const qint32 &type);
    bool is_type_Set() const;
    bool is_type_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    qint32 m_id;
    bool m_id_isSet;
    bool m_id_isValid;

    QString m_name;
    bool m_name_isSet;
    bool m_name_isValid;

    qint32 m_type;
    bool m_type_isSet;
    bool m_type_isValid;
};

} // namespace MelodixAPI

Q_DECLARE_METATYPE(MelodixAPI::MDGetMvDetail_200_response_data_videoGroup_inner)

#endif // MDGetMvDetail_200_response_data_videoGroup_inner_H
